import 'package:dio/dio.dart';

import 'package:good_app/app/app.dart';
import 'package:good_app/data/data.dart';

class AuthRefreshTokenInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final RestClient _restClient;
  final AppLogger _log;

  AuthRefreshTokenInterceptor({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required RestClient restClient,
    required AppLogger log,
  })  : _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _restClient = restClient,
        _log = log;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      final respStatusCode = err.response?.statusCode ?? 0;
      final reqPath = err.requestOptions.path;

      if (respStatusCode == 403 || respStatusCode == 401) {
        if (reqPath != '/auth/token/refresh') {
          final authRequired =
              err.requestOptions.extra[ConstantsStorage.authRequiredKey] ??
                  false;

          if (authRequired) {
            _log.info('########## Refresh token ##########');
            await _refreshToken(err);
            await _retryRequest(err, handler);
            _log.info('########## Refresh token success ##########');
          } else {
            throw err;
          }
        } else {
          throw err;
        }
      } else {
        throw err;
      }
    } on ExpireTokenException {
      // call logout() function
      handler.next(err);
    } on DioError catch (e) {
      handler.next(e);
    } catch (e, s) {
      _log.error('Error rest client', e, s);
      handler.next(err);
    }
  }

  Future<void> _refreshToken(DioError err) async {
    final refreshToken = await _localSecureStorage.read(
      ConstantsStorage.localStorageRefreshTokenKey,
    );

    if (refreshToken == null) {
      throw ExpireTokenException('Token Expirado');
    }

    final resultRefresh = await _restClient.auth().put(
      '/auth/refresh',
      data: {
        'refresh_token': refreshToken,
      },
    );

    await _localStorage.write<String>(
      ConstantsStorage.localStorageAccessTokenKey,
      resultRefresh.data['access_token'],
    );

    await _localSecureStorage.write(
      ConstantsStorage.localStorageRefreshTokenKey,
      resultRefresh.data['refresh_token'],
    );
  }

  Future<void> _retryRequest(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    _log.info(
      '########## Retry request (${err.requestOptions.path}) ##########',
    );
    final requestOptions = err.requestOptions;

    final result = await _restClient.request(
      requestOptions.path,
      method: requestOptions.method,
      data: requestOptions.data,
      headers: requestOptions.headers,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ),
    );
  }
}
