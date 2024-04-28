import 'package:encrypt/encrypt.dart';

import '../database/database_controller.dart';
import '../../core/encrypt/encrypt.dart';
import '../../core/entities/login_entitie.dart';
import '../../core/rules/login_rules.dart';

class RegisterController {
  final DatabaseController _db;
  final LoginRules _rules = LoginRules();

  RegisterController(this._db);

  Future<Map<String, dynamic>?> register(String username, String password) async {
    if (await _passAllVerifies(username, password) == true) {
      final entity = LoginEntity(
        username: username.toLowerCase(),
        encryptedPassword:
            _getEncrypter().encryptPasswordString(pass: password),
      );
      return await _db.register(entity.toMap(), username);
    }
    return null;
  }

  Future<bool> _passAllVerifies(String username, String password) async {
    if (_rules.verifyPassword(password) == true &&
        _rules.verifyUserName(username) == true) {
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
