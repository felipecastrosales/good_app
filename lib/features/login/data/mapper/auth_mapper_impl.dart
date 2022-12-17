import 'package:injectable/injectable.dart';

import 'package:good_app/features/login/data/models/auth_model.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';

import 'auth_mapper.dart';

@Injectable()
@Singleton(as: AuthMapper)
class AuthMapperImpl extends AuthMapper {
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
}
