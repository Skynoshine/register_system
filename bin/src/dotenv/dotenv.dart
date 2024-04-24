import 'package:dotenv/dotenv.dart';

class Env {
  static String mongoDbUri = '';

  void loadEnv() {
    var env = DotEnv(includePlatformEnvironment: true)..load();
    mongoDbUri = env['MONGO_URI']!;
  }
}
