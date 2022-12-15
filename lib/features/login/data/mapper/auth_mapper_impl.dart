import 'package:injectable/injectable.dart';

import 'package:good_app/features/login/data/models/auth.dart';
import 'package:good_app/features/login/domain/entities/auth.dart';

import 'auth_mapper.dart';

@Injectable()
@Singleton(as: AuthMapper)
class AuthMapperImpl implements AuthMapper {
  @override
  List<AuthEntity> toEntities(List<AuthModel> models) {
    return models.map(toEntity).toList();
  }

  @override
  AuthEntity toEntity(AuthModel model) {
    return AuthEntity(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
    );
  }

  @override
  AuthModel toModel(AuthEntity entity) {
    return AuthModel(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      expiresIn: entity.expiresIn,
    );
  }

  @override
  List<AuthModel> toModels(List<AuthEntity> entities) {
    return entities.map(toModel).toList();
  }
}
