import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  const Failure({this.message});
  final String? message;

  @override
  List<dynamic> get props => [message];
}
