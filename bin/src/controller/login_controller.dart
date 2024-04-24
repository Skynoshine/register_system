import 'package:encrypt/encrypt.dart';

import '../database/database_controller.dart';
import '../encrypt/encrypt.dart';
import '../entities/login_entitie.dart';
import '../rules/login_rules.dart';

class LoginController {
  final DatabaseController _db = DatabaseController();
  final LoginRules _rules = LoginRules();

  Future<void> register(String username, String password) async {
    if (await _passAllVerifies(username) == true) {
      final entity = LoginEntity(
          username: username,
          encryptedPassword:
              _getEncrypter().encryptPasswordString(pass: password));
      return await _db.register(entity.toMap(), username);
    }
    print("Failed, invalid e-mail or accont's already exist");
  }

  Future<bool> _passAllVerifies(String username) async {
    if (_rules.verifyUserName(username) == true &&
        await _verifyRegister(username) == false) {
      return true;
    }
    return false;
  }

  Future<bool> _verifyRegister(String user) async {
    if (await _db.get(user) != null) {
      return true;
    }
    return false;
  }

  Encrypt _getEncrypter() {
    final key = Key.fromSecureRandom(32);
    final Encrypt encrypt = Encrypt(encrypter: Encrypter(AES(key)));
    return encrypt;
  }
}
