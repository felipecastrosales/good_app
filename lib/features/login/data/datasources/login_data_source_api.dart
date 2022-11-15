import 'package:good_app/app/app.dart';
import 'package:good_app/data/data.dart';
import 'package:good_app/features/login/login.dart';

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
