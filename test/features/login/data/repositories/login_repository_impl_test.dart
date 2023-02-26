import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/app/core/logger/app_logger_impl.dart';
import 'package:good_app/features/login/data/models/auth_model.dart';
import 'package:good_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';

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

  const username = UserFixtures.realUsername;
  const password = UserFixtures.realPassword;

  final tAuthModel = UserFixtures().tAuthModel;

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
        username: username,
        password: password,
      ),
    ).thenAnswer(
      (invocation) => Future.value(
        Right(
          tAuthModel,
        ),
      ),
    );

    when(
      () => authMapper.toEntity(tAuthModel),
    ).thenAnswer(
      (invocation) => AuthEntity(
        accessToken: tAuthModel.accessToken,
        refreshToken: tAuthModel.refreshToken,
        expiresIn: tAuthModel.expiresIn,
      ),
    );

    var result = await loginRepositoryImpl.call(
      username: username,
      password: password,
    );

    expect(tAuthModel, isA<AuthModel>());

    expect(result, isA<Right<DefaultError, AuthEntity>>());

    final resultFold = result.fold(
      (error) => error,
      (model) => result,
    );

    expect(resultFold, isA<Right<DefaultError, AuthEntity>>());

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
        username: username,
        password: password,
      ),
    ).thenAnswer(
      (invocation) => Future.value(
        const Left(
          DefaultError.unknown(),
        ),
      ),
    );

    var result = await loginRepositoryImpl.call(
      username: username,
      password: password,
    );

    expect(result, isA<Left<DefaultError, AuthEntity>>());

    final resultFold = result.fold(
      (error) => error,
      (model) => result,
    );

    expect(resultFold, isA<DefaultError>());

    verify(
      () => loginDataSource.call(
        username: username,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginDataSource);
  });
}
