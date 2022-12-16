import 'package:dartz/dartz.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/features/login/domain/entities/auth.dart';

abstract class LoginRepository {
  Future<Either<DefaultError, AuthEntity>> call({
    required String username,
    required String password,
  });
}
