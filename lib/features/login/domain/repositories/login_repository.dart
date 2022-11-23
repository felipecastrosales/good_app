import 'package:dartz/dartz.dart';

import 'package:good_app/app/core/errors/failures/failure.dart';
import 'package:good_app/features/login/domain/entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
}
