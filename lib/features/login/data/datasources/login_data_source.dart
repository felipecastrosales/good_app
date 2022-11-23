import 'package:good_app/features/login/data/models/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
}
