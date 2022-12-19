// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:good_app/app/core/rest_client/dio/dio_rest_client.dart' as _i4;
import 'package:good_app/app/di/registers/register_module.dart' as _i6;
import 'package:good_app/data/storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart'
    as _i5;
import 'package:good_app/features/login/data/mapper/auth_mapper_impl.dart'
    as _i3;
import 'package:injectable/injectable.dart' as _i2;

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
    gh.factory<_i3.AuthMapperImpl>(() => _i3.AuthMapperImpl());
    gh.factory<_i4.DioRestClient>(() => registerModule.dioRestClient);
    gh.factory<_i5.FlutterSecureStorageLocalStorageImpl>(
        () => registerModule.flutterSecureStorageLocalStorageImpl);
    return this;
  }
}

class _$RegisterModule extends _i6.RegisterModule {}
