import 'failure.dart';

class ServerFailure extends Failure {
  @override
  String get message =>
      'Unable to process your request, please try again later.';
}
