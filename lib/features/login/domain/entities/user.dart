import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String username;
  final String imageUrl;
  final DateTime bornDate;

  const User({
    required this.name,
    required this.username,
    required this.imageUrl,
    required this.bornDate,
  });

  @override
  List<Object?> get props => [name, username, imageUrl, bornDate];
}
