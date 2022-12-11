import 'package:good_app/features/login/data/models/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> call({
    required String username,
    required String password,
  });
}
