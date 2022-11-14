import 'package:faker/faker.dart';
import 'package:good_app/features/features.dart';

class UserFixtures {
  final name = faker.person.name();
  final email = faker.internet.email();
  final bornDate = faker.date.dateTime();
  final password = faker.internet.password();

  var tUser = User(
    bornDate: faker.date.dateTime(),
    email: faker.internet.email(),
    name: faker.person.name(),
    imageUrl: faker.image.image(),
  );
}
