import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:dartz/dartz.dart';
import 'package:good_app/features/user/data/models/user_model.dart';
import 'package:good_app/features/user/data/sources/user_data_source.dart';

class UserRemoteDataSource implements UserDataSource {
  @override
  Future<Either<DefaultError, UserModel>> call() {
    throw UnimplementedError();
  }
}
