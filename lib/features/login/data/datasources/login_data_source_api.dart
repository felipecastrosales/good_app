import 'package:good_app/app/app.dart';
import 'package:good_app/data/data.dart';
import 'package:good_app/features/login/login.dart';

class LoginDataSourceApi implements LoginDataSource {
  final RestClient _restClient;

  LoginDataSourceApi({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      const baseUrl = ConstantsAPI.baseUrl;
      var response = await _restClient.post(
        baseUrl,
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
