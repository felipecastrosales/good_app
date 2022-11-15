import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/app.dart';

class MockRestClient extends Mock implements RestClient {
  MockRestClient() {
    when(auth).thenReturn(this);
    when(unAuth).thenReturn(this);
  }
}
