import '../database/database_controller.dart';

class LoginController {
  final DatabaseController _db;

  LoginController(this._db);

  Future<bool> _verifyRegister(String user) async {
    final userData = await _db.get(user);
    return userData != null;
  }

  Future<Map<String, dynamic>?> getUser(String user) async {
    if (await _verifyRegister(user) == true) {
      return _db.get(user);
    }
    return null;
  }
}
