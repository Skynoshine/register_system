import 'password_rules.dart';
import 'username_rules.dart';

final class LoginRules {
  final _userNameRules = UserNameRules();
  final _passwordRules = PasswordRules();

  bool verifyUserName(String username) {
    return _userNameRules.verifyUserName(username);
  }

  bool verifyPassword(String password) {
    return _passwordRules.verifyPassword(password);
  }
}


