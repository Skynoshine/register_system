import 'package:email_validator/email_validator.dart';

final class UserNameRules {
  bool verifyUserName(String username) {
    if (EmailValidator.validate(username)) {
      return true;
    }
    print("E-mail incorreto!");
    return false;
  }
}