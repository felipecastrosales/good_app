import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String? message;
  const Failure({this.message});

  @override
  List<dynamic> get props => [message];
}
