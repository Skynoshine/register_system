import 'src/controller/login_controller.dart';
import 'src/database/database_controller.dart';
import 'src/dotenv/dotenv.dart';

void main() async {
  Env().loadEnv();
  final db = DatabaseController();
  final ct = LoginController();

  final String username = 'example-account@gmail.com';
  final String password = 'mypassword123';

  await ct.register(username, password);
  final content = await db.get(username);
  print('Result: $content');
}
