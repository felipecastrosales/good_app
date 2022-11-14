import 'package:good_app/features/login/login.dart';

abstract class LoginDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
  });
}
