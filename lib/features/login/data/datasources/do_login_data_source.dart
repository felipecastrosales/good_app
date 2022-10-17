import 'package:good_app/features/login/login.dart';

abstract class DoLoginDataSource {
  Future<UserModel> doLogin({
    required String email,
    required String password,
  });
}
