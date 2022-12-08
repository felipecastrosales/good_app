import 'package:faker/faker.dart';

import 'package:good_app/features/login/data/models/user_model.dart';

class UserFixtures {
  final username = faker.internet.userName();
  final imageUrl = faker.image.image();
  final bornDate = faker.date.dateTime();
  final password = faker.internet.password();

  final tUser = UserModel(
    name: faker.person.name(),
    username: faker.internet.userName(),
    imageUrl: faker.image.image(),
    bornDate: faker.date.dateTime(),
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
}
