import 'package:dio/dio.dart';

import 'package:good_app/data/constants/constants_storage.dart';
import 'package:good_app/data/storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authRequired =
        options.extra[ConstantsStorage.authRequiredKey] ?? false;
    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(ConstantsStorage.localStorageAccessTokenKey);
      if (accessToken == null) {
        // call logout() function
        return handler.reject(
          DioError(
            requestOptions: options,
            error: 'Expire Token',
            type: DioErrorType.cancel,
          ),
        );
      }
      options.headers['Authorization'] = accessToken;
    } else {
      options.headers.remove('Authorization');
    }
    handler.next(options);
  }
}
