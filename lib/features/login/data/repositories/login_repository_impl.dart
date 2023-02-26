import 'package:dartz/dartz.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/features/login/data/datasources/login_data_source.dart';
import 'package:good_app/features/login/data/mapper/auth_mapper.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';
import 'package:good_app/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required LoginDataSource loginDataSource,
    required AuthMapper authMapper,
    required AppLogger log,
  })  : _loginDataSource = loginDataSource,
        _authMapper = authMapper,
        _log = log;

  final LoginDataSource _loginDataSource;
  final AuthMapper _authMapper;
  final AppLogger _log;

  @override
  Future<Either<DefaultError, AuthEntity>> call({
    required String username,
    required String password,
  }) async {
    final result = await _loginDataSource.call(
      username: username,
      password: password,
    );
    _log.debug('LoginRepositoryImpl result: $result');
    return result.fold(
      (error) => Left(error),
      (model) => Right(_authMapper.toEntity(model)),
    );
  }
}
