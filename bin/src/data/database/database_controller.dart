import 'package:mongo_dart/mongo_dart.dart';

import '../../core/dotenv/dotenv.dart';

class DatabaseController {
  late Db _db;

  Future<Db> _connect() async {
    _db = await Db.create(Env.mongoDbUri);
    try {
      await _db.open();
      print(_db.state);
    } catch (e) {
      print(e);
    }
    return _db;
  }

  Future<void> _close() async {
    if (_db.isConnected) {
      try {
        await _db.close();
        print(_db.state);
      } catch (e) {
        print(e);
      }
    }
  }

  Future register(Map<String, dynamic> data, String username) async {
    await _connect();
    await _db.collection('login-test').insert(data);
    await _close();
  }

  Future<Map<String, dynamic>?> get(String user) async {
    await _connect();
    final collection = _db.collection('login-test');
    final table = where.eq("username", user);

    final response = await collection.findOne(table);

    await _close();
    return response;
  }
}
