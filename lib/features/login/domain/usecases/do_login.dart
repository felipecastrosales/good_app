import 'package:dartz/dartz.dart';
import 'package:good_app/app/app.dart';
import 'package:good_app/features/features.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
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
      email: params.email,
      password: params.password,
    );
  }
}
