import 'package:flutter_test/flutter_test.dart';

import 'package:good_app/features/features.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('Should convert model to map', () {
    final map = UserFixtures().model.toMap();
    expect(map, UserFixtures().userApi);
  });

  test('Should convert model to json', () async {
    final data = await RootBundle.loadString('assets/fixtures/user.json');
    final userJson = UserFixtures().model.toJson();
    final user = UserModel.fromJson(data);
    expect(user.toJson(), userJson);
  });

  test('Should get user from json', () async {
    final data = await RootBundle.loadString('assets/fixtures/user.json');
    final userJson = UserModel.fromJson(data);
    expect(userJson, UserFixtures().model);
  });

  test('Should get user from map', () async {
    final userMap = UserModel.fromMap(UserFixtures().userApi);
    expect(userMap, UserFixtures().model);
  });

  test('Should get user from Firebase', () async {
    final userMap = UserModel.fromFirebase(UserFixtures().userApi);
    expect(userMap, UserFixtures().model);
  });
}
