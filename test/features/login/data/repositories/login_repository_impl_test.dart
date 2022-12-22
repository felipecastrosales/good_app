import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/app/core/logger/app_logger_impl.dart';
import 'package:good_app/features/login/data/repositories/login_repository_impl.dart';

import '../../../../fixtures/mocks/mock_app_logger.dart';
import '../../../../fixtures/mocks/mock_auth_mapper.dart';
import '../../../../fixtures/mocks/mock_login_data_source.dart';
import '../../../../fixtures/models/user_fixtures.dart';

void main() {
  late MockLoginDataSource loginDataSource;
  late LoginRepositoryImpl loginRepositoryImpl;
  late MockLogger logger;
  late AppLogger appLogger;
  late MockAuthMapper authMapper;

  final user = UserFixtures();
  final tUser = user.tUser;
  final username = user.username;
  final password = user.password;
  final tAuthModel = user.tAuthModel;
  // final tAuthEntity = user.tAuthEntity;

  setUp(() {
    loginDataSource = MockLoginDataSource();
    logger = MockLogger();
    authMapper = MockAuthMapper();
    appLogger = AppLoggerImpl(logger: logger);
    loginRepositoryImpl = LoginRepositoryImpl(
      loginDataSource: loginDataSource,
      authMapper: authMapper,
      log: appLogger,
    );
  });

  test('Should login', () async {
    when(
      () => loginDataSource.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      // (invocation) async => Right(tAuthEntity),
      (invocation) async => Right(tAuthModel),
    );

    var result = await loginRepositoryImpl.call(
      username: username,
      password: password,
    );

    expect(result, isA<Right>());
    expect(result, Right(tUser));

    verify(
      () => loginDataSource.call(
        username: username,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginDataSource);
  });

  test('Should throw error when do login', () async {
    when(
      () => loginDataSource.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenThrow(const Left(DefaultError.unknown()));

    var result = await loginRepositoryImpl.call(
      username: username,
      password: password,
    );

    expect(result, isA<Left>());
    expect(result, const Left(DefaultError.unknown()));

    verify(
      () => loginDataSource.call(
        username: username,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginDataSource);
  });
}
