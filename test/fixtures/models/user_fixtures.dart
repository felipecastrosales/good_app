import 'package:faker/faker.dart';

import 'package:good_app/features/login/data/models/auth_model.dart';
import 'package:good_app/features/login/data/models/user_model.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';

class UserFixtures {
  final username = faker.internet.userName();
  final imageUrl = faker.image.image();
  final bornDate = faker.date.dateTime();
  final password = faker.internet.password();

  final realUsername = 'johndoe';
  final realPassword = 'j0hnd0321';

  final tUser = UserModel(
    name: faker.person.name(),
    username: faker.internet.userName(),
    imageUrl: faker.image.image(),
    bornDate: faker.date.dateTime(),
  );

  final tRealUser = UserModel(
    name: 'John Doe',
    username: 'j0hnd0321',
    imageUrl: '',
    bornDate: DateTime(1985, 2, 5),
  );

  final userApi = {
    'name': 'felipecastrosales',
    'bornDate': DateTime(2003, 12, 26).toIso8601String(),
    'imageUrl': 'https://github.com/felipecastrosales.png',
    'username': 'felipecastrosales'
  };

  var model = UserModel(
    name: 'felipecastrosales',
    bornDate: DateTime(2003, 12, 26),
    imageUrl: 'https://github.com/felipecastrosales.png',
    username: 'felipecastrosales',
  );

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
}
