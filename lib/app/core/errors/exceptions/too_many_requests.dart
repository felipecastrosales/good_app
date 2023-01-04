class TooManyRequestsException implements Exception {
  TooManyRequestsException(this.message);
  final String message;
}
