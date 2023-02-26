class ConstantsApi {
  static const base =
      'http://ec2-54-226-60-142.compute-1.amazonaws.com:8080/api';
  static const apiVersion = 'v1';
  static const baseUrl = '$base/$apiVersion';
  static const auth = '$baseUrl/auth/token';
  static const refresh = '$baseUrl/auth/token/refresh';
}
