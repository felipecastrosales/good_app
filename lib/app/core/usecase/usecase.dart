import 'package:dartz/dartz.dart';

import 'package:good_app/app/core/core.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
