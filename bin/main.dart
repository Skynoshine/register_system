import 'src/core/dotenv/dotenv.dart';
import 'src/data/controller/http_controller.dart';
import 'src/data/controller/login_controller.dart';
import 'src/data/controller/register_controller.dart';
import 'src/data/database/database_controller.dart';

void main() async {
  Env().loadEnv();
  final dbController = DatabaseController();
  final loginController = LoginController(dbController);
  final registerController = RegisterController(dbController);
  final http = HttpController(loginController, registerController);

  http.startServer(host: 'localhost', port: 8080);
}
