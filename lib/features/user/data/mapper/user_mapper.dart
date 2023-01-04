import 'package:good_app/app/core/mappers/mapper_model_as_entity.dart';
import 'package:good_app/features/user/data/models/user_model.dart';
import 'package:good_app/features/user/domain/entities/user_entity.dart';

abstract class UserMapper extends MapperModelAsEntity<UserModel, UserEntity> {}
