import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';
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
  // final MockLoginDataSource loginDataSource = MockLoginDataSource();
  // final LoginRepositoryImpl loginRepositoryImpl = LoginRepositoryImpl();
  // final MockLogger logger = MockLogger();
  // final AppLogger appLogger = MockAppLogger();
  // final MockAuthMapper authMapper = MockAuthMapper();

  const username = UserFixtures.realUsername;
  const password = UserFixtures.realPassword;
  final tAuthModel = UserFixtures().tAuthModel;
  // final tUser = user.tUser;
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
        username: username,
        password: password,
      ),
    ).thenAnswer(
      // (invocation) async => Right(tAuthEntity),
      (invocation) => Future.value(
        Right(
          tAuthModel,
        ),
      ),
    );

    final tAuthModelToEntity = authMapper.toEntity(tAuthModel);

    var result = await loginRepositoryImpl.call(
      username: username,
      password: password,
    );

    // when

    expect(tAuthModelToEntity, isA<AuthEntity>());

    // expect(result, isA<Right>());
    expect(result, isA<Right<DefaultError, AuthEntity>>());
    // expect(result, Right(tUser));
    //  Right(_authMapper.toEntity(model)),

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
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenThrow(
      const Left(
        DefaultError.unknown(),
      ),
    );

    var result = await loginRepositoryImpl.call(
      username: username,
      password: password,
    );

    expect(
      result,
      // isA<Future<Either<DefaultError, AuthModel>>>(),
      isA<Left>(),
    );

    verify(
      () => loginDataSource.call(
        username: username,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginDataSource);
  });
}
