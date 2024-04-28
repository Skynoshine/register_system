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
    return numbersInPassword >= 1;
  }

  bool _verifyLength(String input) {
    return input.length >= 8;
  }
}
