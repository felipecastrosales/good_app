import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/failures/password_wrong.dart';
import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/app/core/logger/app_logger_impl.dart';
import 'package:good_app/features/login/data/repositories/login_repository_impl.dart';

import '../../../../fixtures/mocks/mock_app_logger.dart';
import '../../../../fixtures/mocks/mock_login_data_source.dart';
import '../../../../fixtures/models/user_fixtures.dart';

void main() {
  late MockLoginDataSource loginDataSource;
  late LoginRepositoryImpl loginRepositoryImpl;
  late MockLogger logger;
  late AppLogger appLogger;

  final user = UserFixtures();

  setUp(() {
    loginDataSource = MockLoginDataSource();
    logger = MockLogger();
    appLogger = AppLoggerImpl(logger: logger);
    loginRepositoryImpl = LoginRepositoryImpl(
      loginDataSource: loginDataSource,
      log: appLogger,
    );
  });

  test('Should login', () async {
    when(
      () => loginDataSource.call(
        username: user.username,
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (invocation) async => user.tUser,
    );

    var result = await loginRepositoryImpl.call(
      username: user.username,
      password: user.password,
    );

    expect(result, isA<Right>());
    expect(result, Right(user.tUser));

    verify(
      () => loginDataSource.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).called(1);

    verifyNoMoreInteractions(loginDataSource);
  });

  test('Should error when do login', () async {
    when(
      () => loginDataSource.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenThrow(PasswordWrongFailure());

    var result = await loginRepositoryImpl.call(
      username: user.username,
      password: user.password,
    );

    expect(result, isA<Left>());
    expect(result, Left(PasswordWrongFailure()));

    verify(
      () => loginDataSource.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).called(1);

    verifyNoMoreInteractions(loginDataSource);
  });
}
