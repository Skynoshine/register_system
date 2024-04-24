import 'package:encrypt/encrypt.dart';

final class Encrypt {
  final _iv = IV.fromSecureRandom(16);
  final Encrypter encrypter;

  Encrypt({
    required this.encrypter,
  });

  Encrypted _encryptPassword({required String pass}) {
    return encrypter.encrypt(pass, iv: _iv);
  }
  
  String encryptPasswordString({required String pass}) {
    final encrypted = _encryptPassword(pass: pass);
    return encrypted.base64;
  }
}