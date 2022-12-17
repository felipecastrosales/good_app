import 'package:good_app/app/core/mappers/mapper_entity.dart';
import 'package:good_app/app/core/mappers/mapper_model.dart';
import 'package:good_app/features/login/data/models/auth_model.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';

abstract class AuthMapper
    with
        MapperEntity<AuthEntity, AuthModel>,
        MapperModel<AuthModel, AuthEntity> {}
