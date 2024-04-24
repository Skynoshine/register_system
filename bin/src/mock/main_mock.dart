import 'controller_mock.dart';
import 'database_controller_mock.dart';

void main() async {
  final db = DatabaseControllerMock();
  final ct = LoginControllerMock();

  final String username = 'emilyvasques@gmail.com';
  final String password = 'my_pass_is_secure';

  await ct.register(username, password);
  await db.get(username);
}
