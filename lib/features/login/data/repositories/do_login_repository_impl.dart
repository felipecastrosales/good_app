import 'package:dartz/dartz.dart';
import 'package:good_app/app/core/errors/errors.dart';
import 'package:good_app/app/core/logger/logger.dart';
import 'package:good_app/features/login/login.dart';

class DoLoginRepositoryImpl implements DoLoginRepository {
  final DoLoginDataSource _doLoginDataSource;
  final AppLogger _log;

  DoLoginRepositoryImpl({
    required DoLoginDataSource doLoginDataSource,
    required AppLogger log,
  })  : _doLoginDataSource = doLoginDataSource,
        _log = log;

  @override
  Future<Either<Failure, User>> doLogin({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _doLoginDataSource.doLogin(
        email: email,
        password: password,
      );
      return Right(user);
    } on Failure catch (e, s) {
      _log.error('Error on DoLoginRepositoryImpl', e, s);
      return Left(e);
    }
  }
}
