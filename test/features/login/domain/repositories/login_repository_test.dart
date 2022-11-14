import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_app/app/app.dart';
import 'package:good_app/features/features.dart';
import 'package:good_app/features/login/data/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/user_fixtures.dart';

class MockLoginDataSource extends Mock implements LoginDataSource {}

class MockLoginRepository extends Mock implements LoginRepository {}

class MockRestClient extends Mock implements RestClient {}

class MockLogger extends Mock implements AppLogger {}

void main() {
  // late MockLoginDataSource loginDataSource;
  // late MockLoginRepository loginRepository;
  // late MockRestClient restClient;
  LoginDataSource loginDataSource = MockLoginDataSource();
  LoginRepository loginRepository = MockLoginRepository();
  RestClient restClient = MockRestClient();
  AppLogger logger = MockLogger();
  LoginRepository loginRepositoryImpl = LoginRepositoryImpl(
    loginDataSource: loginDataSource,
    log: logger,
  );

  final user = UserFixtures();

  setUp(() {
    // loginDataSource = MockLoginDataSource();
    // loginRepository = MockLoginRepository();
    // restClient = MockRestClient();
  });

  test('Should login', () async {
    when(
      () => loginDataSource.login(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (invocation) async => user.tUser,
    );

    var result = await loginRepositoryImpl.login(
      username: user.username,
      password: user.password,
    );

    expect(result, isA<Right>());
    expect(result, Right(user.tUser));

    verify(
      () => loginDataSource.login(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).called(1);

    verifyNoMoreInteractions(loginDataSource);
  });
}
