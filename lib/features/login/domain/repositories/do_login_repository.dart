import 'package:dartz/dartz.dart';
import 'package:good_app/app/core/core.dart';
import 'package:good_app/features/login/login.dart';

abstract class DoLoginRepository {
  Future<Either<Failure, User>> doLogin({
    required String email,
    required String password,
  });
}
