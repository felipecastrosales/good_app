import 'package:good_app/app/core/errors/failures/server.dart';
import 'package:good_app/app/core/rest_client/rest_client.dart';
import 'package:good_app/data/constants/constants_api.dart';
import 'package:good_app/features/login/data/models/user_model.dart';

import 'login_data_source.dart';

class LoginDataSourceApi implements LoginDataSource {
  final RestClient _restClient;
  final AppLogger _log;

  LoginDataSourceApi({
    required RestClient restClient,
    required AppLogger log,
  })  : _restClient = restClient,
        _log = log;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      const baseUrl = ConstantsApi.auth;
      var response = await _restClient.post(
        baseUrl,
        data: {
          'username': username,
          'password': password,
        },
      );
      _log.info('Login response: $response');
      return UserModel.fromMap(response.data);
    } catch (e, s) {
      _log.error('Error on $this', e, s);
      throw ServerFailure();
    }
  }
}
