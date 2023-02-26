import 'package:dartz/dartz.dart';

import 'package:good_app/app/core/errors/failures/failure.dart';
import 'package:good_app/app/core/usecase/usecase.dart';
import 'package:good_app/features/login/domain/entities/user.dart';
import 'package:good_app/features/login/domain/repositories/login_repository.dart';

class LoginParams {
  final String username;
  final String password;

  LoginParams({
    required this.username,
    required this.password,
  });
}

class DoLogin extends UseCase<User, LoginParams> {
  final LoginRepository _loginRepository;

  DoLogin({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await _loginRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}
