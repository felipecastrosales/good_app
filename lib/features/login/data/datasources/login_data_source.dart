import 'package:dartz/dartz.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/features/login/data/models/auth_model.dart';

abstract class LoginDataSource {
  Future<Either<DefaultError, AuthModel>> call({
    required String username,
    required String password,
  });
}
