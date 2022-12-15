class AuthEntity {
  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  bool get isExpired => expiresIn < DateTime.now().millisecondsSinceEpoch;
}
