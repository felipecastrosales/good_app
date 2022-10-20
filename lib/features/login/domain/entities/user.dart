import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String imageUrl;
  final DateTime bornDate;

  const User({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.bornDate,
  });

  @override
  List<Object?> get props => [name, email, imageUrl, bornDate];
}
