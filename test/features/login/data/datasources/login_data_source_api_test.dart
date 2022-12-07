import 'package:flutter_test/flutter_test.dart';
import 'package:good_app/data/constants/constants_api.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/failures/server.dart';
import 'package:good_app/app/core/rest_client/rest_client_response.dart';
import 'package:good_app/features/login/data/datasources/login_data_source_api.dart';
import 'package:good_app/features/login/data/models/user_model.dart';

import '../../../../app/core/rest_client/mock_rest_client.dart';
import '../../../../fixtures/mocks/mock_app_logger.dart';
import '../../../../fixtures/models/user_fixtures.dart';

void main() {
  late MockRestClient restClient;
  late LoginDataSourceApi loginDataSourceApi;
  late MockAppLogger log;

  final tUser = UserFixtures();
  final tUsername = tUser.username;
  final tPassword = tUser.password;
  const baseAuthUrl = ConstantsApi.auth;

  setUp(() {
    restClient = MockRestClient();
    log = MockAppLogger();
    loginDataSourceApi = LoginDataSourceApi(
      restClient: restClient,
      log: log,
    );
  });

  test('Should do login on API', () async {
    when(
      () => restClient.post(
        any(),
        data: {
          'username': tUsername,
          'password': tPassword,
        },
      ),
    ).thenAnswer(
      (invocation) => Future.value(
        RestClientResponse(
          data: UserFixtures().userApi,
          statusCode: 200,
          statusMessage: 'OK',
        ),
      ),
    );

    UserModel user = await loginDataSourceApi.login(
      username: tUsername,
      password: tPassword,
    );

    expect(user, isA<UserModel>());
    expect(user.toMap(), UserFixtures().userApi);

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
        any(),
        data: {
          'username': tUsername,
          'password': tPassword,
        },
      ),
    ).thenAnswer(
      (invocation) => Future.value(
        RestClientResponse(
          data: null,
          statusCode: 400,
          statusMessage: 'Bad Request',
        ),
      ),
    );

    expect(
      () async => await loginDataSourceApi.login(
        username: tUsername,
        password: tPassword,
      ),
      throwsA(isA<ServerFailure>()),
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
