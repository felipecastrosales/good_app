import 'package:good_app/app/core/errors/failures/server.dart';
import 'package:good_app/app/core/rest_client/rest_client.dart';
import 'package:good_app/data/constants/constants_api.dart';
import 'package:good_app/features/login/data/models/user_model.dart';

import 'login_data_source.dart';

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
      const baseAuthUrl = ConstantsApi.auth;
      var response = await _restClient.post(
        baseAuthUrl,
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
