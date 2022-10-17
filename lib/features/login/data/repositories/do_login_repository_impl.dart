import 'package:good_app/app/core/errors/errors.dart';
import 'package:good_app/features/login/login.dart';

class DoLoginRepositoryImpl implements DoLoginRepository {
  final DoLoginDataSource _doLoginDataSource;

  DoLoginRepositoryImpl({
    required DoLoginDataSource doLoginDataSource,
  }) : _doLoginDataSource = doLoginDataSource;

  @override
  // ignore: override_on_non_overriding_member
  Future<UserModel> doLogin({
    required String email,
    required String password,
  }) async {
    try {
      return await _doLoginDataSource.doLogin(
        email: email,
        password: password,
      );
    } catch (e) {
      throw ServerFailure();
    }
  }
}
