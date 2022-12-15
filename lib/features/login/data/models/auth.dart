import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, Object?> json) =>
      _$AuthModelFromJson(json);
}
