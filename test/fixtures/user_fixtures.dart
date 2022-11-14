import 'package:faker/faker.dart';
import 'package:good_app/features/features.dart';

class UserFixtures {
  final username = faker.person.name();
  final email = faker.internet.email();
  final imageUrl = faker.image.image();
  final bornDate = faker.date.dateTime();
  final password = faker.internet.password();

  var tUser = UserModel(
    name: faker.person.name(),
    email: faker.internet.email(),
    imageUrl: faker.image.image(),
    bornDate: faker.date.dateTime(),
  );
}
