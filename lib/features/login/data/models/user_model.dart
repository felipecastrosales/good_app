import 'dart:convert';

import 'package:good_app/features/login/domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel({
    required super.name,
    required super.bornDate,
    required super.imageUrl,
    required super.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'imageUrl': imageUrl,
      'bornDate': bornDate.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      username: map['username'],
      imageUrl: map['imageUrl'],
      bornDate: DateTime.parse(map['bornDate']),
    );
  }

  factory UserModel.fromFirebase(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      username: map['username'],
      imageUrl: map['imageUrl'],
      bornDate: DateTime.parse(map['bornDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
