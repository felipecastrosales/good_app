import 'package:dartz/dartz.dart';
import 'package:good_app/app/core/errors/errors.dart';
import 'package:good_app/app/core/logger/logger.dart';
import 'package:good_app/features/login/login.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;
  final AppLogger _log;

  LoginRepositoryImpl({
    required LoginDataSource loginDataSource,
    required AppLogger log,
  })  : _loginDataSource = loginDataSource,
        _log = log;

  @override
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  }) async {
    try {
      final user = await _loginDataSource.login(
        username: username,
        password: password,
      );
      _log.info('User logged in: $user');
      return Right(user);
    } on Failure catch (e, s) {
      _log.error('Error on $this', e, s);
      return Left(e);
    }
  }
}
