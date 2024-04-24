import '../database/database_controller.dart';

class DatabaseControllerMock extends DatabaseController {
  final Map<String, dynamic> _database = {};

  Future<void> _connect() async {
    // Simulate connecting to the database
    print('Connecting to the database (mock)');
  }

  Future<void> _close() async {
    // Simulate closing the database connection
    print('Closing the database connection (mock)');
  }

  Future<bool> _contains(String username) async {
    // Check if the username exists in the mock database
    return _database.containsKey(username);
  }

  @override
  Future<void> register(Map<String, dynamic> data, String username) async {
    // Register the user in the mock database
    await _connect();
    if (await _contains(username)) {
      await _close();
      throw Exception('User already exists in the mock database');
    } else {
      print('registering user - $data');
      _database[username] = data;
      await _close();
    }
  }

  @override
  Future<Map<String, dynamic>?> get(String username) async {
    await _connect();
    final data = _database[username];
    print(_database);
    await _close();
    return data;
  }
}
