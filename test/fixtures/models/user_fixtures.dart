import 'package:faker/faker.dart';

import 'package:good_app/features/login/data/models/auth_model.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';

class UserFixtures {
  final username = faker.internet.userName();
  final imageUrl = faker.image.image();
  final bornDate = faker.date.dateTime();
  final password = faker.internet.password();

  final realUsername = 'johndoe';
  final realPassword = 'j0hnd0321';

  var tAuthModel = AuthModel(
    accessToken: faker.guid.guid(),
    refreshToken: faker.guid.guid(),
    expiresIn: faker.randomGenerator.integer(1000),
  );

  var tAuthEntity = AuthEntity(
    accessToken: faker.guid.guid(),
    refreshToken: faker.guid.guid(),
    expiresIn: faker.randomGenerator.integer(1000),
  );

  static const tAccessToken = '012345678910';
  static const tRefreshToken = '109876543210';
  static const tExpiresIn = 10000;

  static const userReturnFromApi = {
    'access': tAccessToken,
    'refresh': tRefreshToken,
    'expireIn': tExpiresIn,
  };

  final authApi = AuthModel.fromJson(userReturnFromApi);
}
