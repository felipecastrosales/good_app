import 'package:dartz/dartz.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/app/core/usecase/usecase.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';
import 'package:good_app/features/login/domain/repositories/login_repository.dart';

class LoginParams {
  LoginParams({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class DoLogin extends UseCase<AuthEntity, LoginParams> {
  DoLogin({
    required LoginRepository repository,
  }) : _repository = repository;

  final LoginRepository _repository;

  @override
  Future<Either<DefaultError, AuthEntity>> call(LoginParams params) async {
    return _repository.call(
      username: params.username,
      password: params.password,
    );
  }
}
