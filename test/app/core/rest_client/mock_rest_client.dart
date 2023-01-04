import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/rest_client/rest_client.dart';

class MockRestClient extends Mock implements RestClient {
  MockRestClient() {
    mockAuth();
    mockUnAuth();
  }

  void mockAuth() => when(auth).thenReturn(this);
  void mockUnAuth() => when(unAuth).thenReturn(this);
}
