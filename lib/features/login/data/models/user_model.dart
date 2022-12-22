import 'dart:convert';

import 'package:good_app/features/login/domain/entities/user_entity.dart';

class UserModel extends User {
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromFirebase(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      username: map['username'],
      imageUrl: map['imageUrl'],
      bornDate: DateTime.parse(map['bornDate']),
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      username: map['username'],
      imageUrl: map['imageUrl'],
      bornDate: DateTime.parse(map['bornDate']),
    );
  }

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

  String toJson() => json.encode(toMap());
}
