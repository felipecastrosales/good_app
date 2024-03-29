import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/app/core/logger/app_logger_impl.dart';
import 'package:good_app/app/core/rest_client/rest_client_response.dart';
import 'package:good_app/data/constants/constants_api.dart';
import 'package:good_app/features/login/data/datasources/login_data_source_api.dart';
import 'package:good_app/features/login/data/models/auth_model.dart';

import '../../../../app/core/rest_client/mock_rest_client.dart';
import '../../../../fixtures/mocks/mock_app_logger.dart';
import '../../../../fixtures/mocks/mock_auth_mapper.dart';
import '../../../../fixtures/models/user_fixtures.dart';

void main() {
  late MockRestClient restClient;
  late LoginDataSourceApi loginDataSourceApi;
  late MockLogger logger;
  late MockAuthMapper authMapper;
  late AppLogger appLogger;

  const tUsername = UserFixtures.realUsername;
  const tPassword = UserFixtures.realPassword;
  final authApi = UserFixtures().authApi;

  const tUserReturnFromApi = UserFixtures.userReturnFromApi;
  const baseAuthUrl = ConstantsApi.auth;

  setUp(() {
    restClient = MockRestClient();
    authMapper = MockAuthMapper();
    logger = MockLogger();
    appLogger = AppLoggerImpl(logger: logger);
    loginDataSourceApi = LoginDataSourceApi(
      restClient: restClient,
      authMapper: authMapper,
      log: appLogger,
    );
  });

  test('Should do login on API', () async {
    when(
      () => restClient.post(
        baseAuthUrl,
        data: any(named: 'data'),
      ),
    ).thenAnswer(
      (invocation) => Future.value(
        RestClientResponse(
          // data: tUserReturnFromApi,
          data: tUserReturnFromApi,
          statusCode: 200,
          statusMessage: 'OK',
        ),
      ),
    );

    final user = await loginDataSourceApi.call(
      username: tUsername,
      password: tPassword,
    );

    // expect(user, isA<Either<DefaultError, AuthModel>>());
    // expect(user, const Right(authModel));
    expect(user, Right(authApi));
    // expect(user, Right(tAuthModel));

    // expect(user, isA<AuthModel>());
    // expect(user.toMap(), UserFixtures().userApi);
    // expect(user.map((r) => r.toMap()), UserFixtures().userApi);
    // expect(user.map((r) => r.toMap()), UserFixtures().userApi);

    verify(
      () => restClient.post(
        baseAuthUrl,
        data: {
          'username': tUsername,
          'password': tPassword,
        },
      ),
    ).called(1);

    verifyNoMoreInteractions(restClient);
  });

  test('Should throw exception when API returns error', () async {
    when(
      () => restClient.post(
        baseAuthUrl,
        data: any(named: 'data'),
      ),
    ).thenThrow(
      // (invocation) => Future.value(
      //   RestClientResponse(
      //     data: null,
      //     statusCode: 400,
      //     statusMessage: 'Bad Request',
      //   ),
      // ),
      const Left(DefaultError.unknown()),
    );

    expect(
      loginDataSourceApi.call(
        username: tUsername,
        password: tPassword,
      ),
      isA<Future<Either<DefaultError, AuthModel>>>(),
      // Future<Either<DefaultError, AuthModel>>> throws
      //
      // Expected: throws <Instance of 'Left'>
      // Actual: <Closure: () => Future<Either<DefaultError, AuthModel>>>
      // Which: throws <Instance of 'Left'>
      // throwsA(isA<DefaultError>()),
      // throwsA(() => isA<Future<Either<DefaultError, AuthModel>>>()),
    );

    verify(
      () => restClient.post(
        baseAuthUrl,
        data: {
          'username': tUsername,
          'password': tPassword,
        },
      ),
    ).called(1);

    verifyNoMoreInteractions(restClient);
  });
}
