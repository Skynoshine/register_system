import 'package:encrypt/encrypt.dart';

import '../controller/login_controller.dart';
import '../encrypt/encrypt.dart';
import '../entities/login_entitie.dart';
import 'database_controller_mock.dart';

class LoginControllerMock extends LoginController {
  final DatabaseControllerMock _db = DatabaseControllerMock();
  final bool _usernameIsValid = true;
  final bool _userDoesNotExist = true;

  @override
  Future<void> register(String username, String password) async {
    // Check if the username is valid and the user does not already exist
    if (_usernameIsValid && _userDoesNotExist) {
      final entity = LoginEntity(
        username: username,
        encryptedPassword:
            _getEncrypter().encryptPasswordString(pass: password),
      );
      return await _db.register(entity.toMap(), username);
    } else {
      print("Registration failed: Invalid username or user already exists");
    }
  }

  Encrypt _getEncrypter() {
    // Simulate generating an encrypter
    final key = Key.fromSecureRandom(32);
    return Encrypt(encrypter: Encrypter(AES(key)));
  }
}
