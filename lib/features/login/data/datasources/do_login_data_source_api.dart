import 'package:good_app/app/app.dart';
import 'package:good_app/features/login/login.dart';

class DoLoginDataSourceApi implements DoLoginDataSource {
  final RestClient _restClient;

  DoLoginDataSourceApi({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<UserModel> doLogin({
    required String email,
    required String password,
  }) async {
    try {
      var response = await _restClient.post(
        'http://www.api.com/user',
        data: {
          'email': email,
          'password': password,
        },
      );
      return UserModel.fromMap(response.data);
    } catch (e) {
      throw ServerFailure();
    }
  }
}
