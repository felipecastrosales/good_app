import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    String? avatarUrl,
    required String name,
    String? firstName,
    String? lastName,
    String? taxpayerId,
    String? taxpayerIdFormatted,
    String? identityDocument,
    String? birthday,
    bool? isBlocked,
    bool? isStaff,
    bool? isActive,
    required String dateJoined,
    List<dynamic>? emails,
    List<dynamic>? phones,
    List<dynamic>? addresses,
    required String createdAt,
    required String updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$_UserModel.fromJson(json);
}
