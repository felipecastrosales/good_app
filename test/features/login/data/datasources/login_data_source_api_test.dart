import 'package:flutter_test/flutter_test.dart';
import 'package:good_app/app/core/rest_client/rest_client_response.dart';

import 'package:good_app/features/features.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../app/core/rest_client/mock_rest_client.dart';
import '../../../../fixtures/fixtures.dart';

void main() {
  late MockRestClient restClient;
  late LoginDataSourceApi loginDataSourceApi;
  late MockAppLogger log;

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
          'username': 'felipecastrosales',
          'password': '261203felipe',
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
      username: 'felipecastrosales',
      password: '261203felipe',
    );

    expect(user, isA<UserModel>());
    expect(user.toMap(), UserFixtures().userApi);

    verify(
      () => restClient.post(
        any(),
        data: {
          'username': 'felipecastrosales',
          'password': '261203felipe',
        },
      ),
    ).called(1);

    verifyNoMoreInteractions(restClient);
  });
}
