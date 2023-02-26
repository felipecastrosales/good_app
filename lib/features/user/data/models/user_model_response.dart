import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'user_model_response.freezed.dart';

@freezed
class UserModelResponse with _$UserModelResponse {
  const factory UserModelResponse({
    required String refresh,
    required String access,
    required String expireIn,
    required UserModel user,
  }) = _UserModelResponse;

  factory UserModelResponse.fromJson(Map<String, dynamic> json) =>
      _$_UserModelResponse.fromJson(json);
}
