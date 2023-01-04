import 'package:dartz/dartz.dart';
import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/features/user/data/models/user_model.dart';

abstract class UserDataSource {
  Future<Either<DefaultError, UserModel>> call();
}
