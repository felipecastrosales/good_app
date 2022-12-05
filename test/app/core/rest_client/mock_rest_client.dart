import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/rest_client/rest_client.dart';

class MockRestClient extends Mock implements RestClient {
  MockRestClient() {
    when(auth).thenReturn(this);
    when(unAuth).thenReturn(this);
  }
}
