class LoginEntity {
  String username;
  String encryptedPassword;

  LoginEntity({
    required this.username,
    required this.encryptedPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'encryptedPassword': encryptedPassword,
    };
  }
}
