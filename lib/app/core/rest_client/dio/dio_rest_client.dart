import 'package:dio/dio.dart';

import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/app/core/rest_client/rest_client.dart';
import 'package:good_app/app/core/rest_client/rest_client_exception.dart';
import 'package:good_app/app/core/rest_client/rest_client_response.dart';
import 'package:good_app/data/constants/constants_api.dart';
import 'package:good_app/data/constants/constants_storage.dart';
import 'package:good_app/data/storage/local_secure_storage.dart';
import 'package:good_app/data/storage/local_storage.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/auth_refresh_token_interceptor.dart';

class DioRestClient implements RestClient {
  DioRestClient({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required AppLogger log,
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(baseOptions ?? _defaultOptions);
    _dio.interceptors.addAll([
      AuthInterceptor(localStorage: localStorage),
      AuthRefreshTokenInterceptor(
        localStorage: localStorage,
        localSecureStorage: localSecureStorage,
        restClient: this,
        log: log,
      ),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    ]);
  }

  late final Dio _dio;

  final _defaultOptions = BaseOptions(
    baseUrl: ConstantsApi.baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  @override
  RestClient auth() {
    _defaultOptions.extra[ConstantsStorage.authRequiredKey] = true;
    return this;
  }

  @override
  RestClient unAuth() {
    _defaultOptions.extra[ConstantsStorage.authRequiredKey] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverter<T>(
      Response<dynamic> response) async {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  Never _throwRestClientException(DioError dioError) {
    final response = dioError.response;
    throw RestClientException(
      error: dioError.error,
      message: response?.statusMessage,
      statusCode: response?.statusCode,
      response: RestClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
      ),
    );
  }
}
