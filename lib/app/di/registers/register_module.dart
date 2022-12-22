import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_app/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:good_app/app/di/locator.dart';
import 'package:good_app/data/storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @injectable
  FlutterSecureStorageLocalStorageImpl
      get flutterSecureStorageLocalStorageImpl =>
          const FlutterSecureStorageLocalStorageImpl(
            instance: FlutterSecureStorage(),
          );

  @injectable
  DioRestClient get dioRestClient => DioRestClient(
        localSecureStorage: getIt(),
        localStorage: getIt(),
        log: getIt(),
      );
}
