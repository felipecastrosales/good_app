import 'failure.dart';

class UnknownFailure extends Failure {
  @override
  String get message => 'Unknown error, please try again later.';
}
