import 'package:good_app/app/app.dart';
import 'package:mocktail/mocktail.dart';

class MockRestClient extends Mock implements RestClient {
  MockRestClient() {
    when(auth).thenReturn(this);
    when(unAuth).thenReturn(this);
  }
}
