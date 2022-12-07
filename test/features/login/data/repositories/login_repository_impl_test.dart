import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/failures/password_wrong.dart';
import 'package:good_app/features/login/data/repositories/login_repository_impl.dart';

import '../../../../fixtures/mocks/mock_app_logger.dart';
import '../../../../fixtures/mocks/mock_login_data_source.dart';
import '../../../../fixtures/models/user_fixtures.dart';

void main() {
  late MockLoginDataSource loginDataSource;
  late MockAppLogger logger;
  late LoginRepositoryImpl loginRepositoryImpl;

  final user = UserFixtures();

  setUp(() {
    loginDataSource = MockLoginDataSource();
    logger = MockAppLogger();
    loginRepositoryImpl = LoginRepositoryImpl(
      loginDataSource: loginDataSource,
      log: logger,
    );
  });

  test('Should login', () async {
    when(
      () => loginDataSource.login(
        username: user.username,
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

  test('Should error when do login', () async {
    when(
      () => loginDataSource.login(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenThrow(PasswordWrongFailure());

    var result = await loginRepositoryImpl.login(
      username: user.username,
      password: user.password,
    );

    expect(result, isA<Left>());
    expect(result, Left(PasswordWrongFailure()));

    verify(
      () => loginDataSource.login(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).called(1);

    verifyNoMoreInteractions(loginDataSource);
  });
}
