import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:good_app/app/core/errors/failures/failure.dart';
import 'package:good_app/app/core/errors/failures/server.dart';
import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/features/login/data/datasources/login_data_source.dart';
import 'package:good_app/features/login/domain/entities/user.dart';
import 'package:good_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;
  final AppLogger _log;

  LoginRepositoryImpl({
    required LoginDataSource loginDataSource,
    required AppLogger log,
  })  : _loginDataSource = loginDataSource,
        _log = log;

  @override
  Future<Either<Failure, User>> call({
    required String username,
    required String password,
  }) async {
    try {
      final user = await _loginDataSource.call(
        username: username,
        password: password,
      );
      _log.info('User logged in: $user');
      return Right(user);
    } on Failure catch (e, s) {
      _log.error('Error on $this', e, s);
      return Left(e);
    } catch (e, s) {
      _log.error('Error on $this', e, s);
      debugPrint('Error on $this: $e');
      debugPrint('Error on $this: $s');
      return Left(
        ServerFailure(),
      );
    }
  }
}
