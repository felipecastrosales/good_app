import 'package:dartz/dartz.dart';
import 'package:good_app/app/core/errors/default/default_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<DefaultError, Type>> call(Params params);
}
