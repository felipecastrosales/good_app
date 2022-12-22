// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:good_app/app/core/logger/app_logger.dart' as _i3;
import 'package:good_app/app/core/logger/app_logger_impl.dart' as _i4;
import 'package:good_app/app/core/rest_client/dio/dio_rest_client.dart' as _i8;
import 'package:good_app/app/di/registers/register_module.dart' as _i15;
import 'package:good_app/data/storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart'
    as _i9;
import 'package:good_app/data/storage/local_secure_storage.dart' as _i10;
import 'package:good_app/features/login/data/datasources/login_data_source.dart'
    as _i14;
import 'package:good_app/features/login/data/mapper/auth_mapper.dart' as _i6;
import 'package:good_app/features/login/data/mapper/auth_mapper_impl.dart'
    as _i7;
import 'package:good_app/features/login/data/repositories/login_repository_impl.dart'
    as _i13;
import 'package:good_app/features/login/domain/repositories/login_repository.dart'
    as _i12;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i5;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.AppLogger>(
        () => _i4.AppLoggerImpl(logger: gh<_i5.Logger>()));
    gh.singleton<_i6.AuthMapper>(_i7.AuthMapperImpl());
    gh.factory<_i8.DioRestClient>(() => registerModule.dioRestClient);
    gh.factory<_i9.FlutterSecureStorageLocalStorageImpl>(
        () => registerModule.flutterSecureStorageLocalStorageImpl);
    gh.factory<_i10.LocalSecureStorage>(() =>
        _i9.FlutterSecureStorageLocalStorageImpl(
            instance: gh<_i11.FlutterSecureStorage>()));
    gh.factory<_i12.LoginRepository>(() => _i13.LoginRepositoryImpl(
          loginDataSource: gh<_i14.LoginDataSource>(),
          authMapper: gh<_i6.AuthMapper>(),
          log: gh<_i3.AppLogger>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i15.RegisterModule {}
