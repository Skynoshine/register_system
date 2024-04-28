class LoginEntity {
  String username;
  String encryptedPassword;

  LoginEntity({
    required this.username,
    required this.encryptedPassword,
  });

  Map<String, dynamic> toMap() {
    final now = DateTime.now().toUtc();
    return {
      'createAt': now.toIso8601String(),
      'updateAt': now.toIso8601String(),
      'username': username,
      'password': encryptedPassword,
    };
  }
}
