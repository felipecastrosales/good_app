import 'package:faker/faker.dart';

import 'package:good_app/features/features.dart';

class UserFixtures {
  final username = faker.person.name();
  final email = faker.internet.email();
  final imageUrl = faker.image.image();
  final bornDate = faker.date.dateTime();
  final password = faker.internet.password();

  final tUser = UserModel(
    name: faker.person.name(),
    email: faker.internet.email(),
    imageUrl: faker.image.image(),
    bornDate: faker.date.dateTime(),
  );

  final userApi = {
    'name': 'felipecastrosales',
    'bornDate': DateTime(2003, 12, 26).toIso8601String(),
    'imageUrl': 'https://github.com/felipecastrosales.png',
    'email': 'soufeliposales@gmail.com'
  };

  var model = UserModel(
    name: 'felipecastrosales',
    bornDate: DateTime(2003, 12, 26),
    imageUrl: 'https://github.com/felipecastrosales.png',
    email: 'soufeliposales@gmail.com',
  );
}
