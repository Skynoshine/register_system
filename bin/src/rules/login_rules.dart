import 'package:email_validator/email_validator.dart';

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

final class UserNameRules {
  bool verifyUserName(String username) {
    if (EmailValidator.validate(username)) {
      return true;
    }
    print("E-mail incorreto!");
    return false;
  }
}

final class PasswordRules {
  bool verifyPassword(String password) {
    if (password.isEmpty) {
      return false;
    }
    return _verifyLength(password) && _verifyNumbersInPassword(password);
  }

  bool _verifyNumbersInPassword(String input) {
    int numbersInPassword = 0;
    for (int i = 0; i < input.length; i++) {
      if (input.codeUnitAt(i) >= 48 && input.codeUnitAt(i) <= 57) {
        numbersInPassword++;
      }
    }
    return numbersInPassword == 1;
  }

  bool _verifyLength(String input) {
    return input.length >= 8;
  }
}
