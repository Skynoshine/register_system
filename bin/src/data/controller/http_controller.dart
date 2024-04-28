import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'login_controller.dart';
import 'register_controller.dart';

class HttpController {
  final LoginController _loginController;
  final RegisterController _registerController;

  HttpController(this._loginController, this._registerController);

  Future<Response> _handleGetUser(Request request) async {
    final userQuery = _getUserQuery(request);

    if (userQuery == null) {
      return _badRequestResponse('User parameter is required');
    }

    final userResponse =
        await _loginController.getUser(userQuery.toLowerCase());

    if (userResponse != null) {
      return _okResponse(userResponse);
    } else {
      return _notFoundResponse('User not found');
    }
  }

  Future<Response> _handleInsertUser(Request request) async {
    final userQuery = _getUserQuery(request);
    final passwordQuery = request.url.queryParameters['password'];

    if (userQuery == null || passwordQuery == null) {
      return _badRequestResponse('User and password parameters are required');
    }

    final getUser = await _loginController.getUser(userQuery.toLowerCase());

    if (getUser != null) {
      return _badRequestResponse('User already exists');
    }

    final registerResult = await _registerController.register(
      userQuery.toLowerCase(),
      passwordQuery,
    );

    if (registerResult != null) {
      final newUserResponse = getUser;
      if (newUserResponse != null) {
        return _okResponse(newUserResponse);
      } else {
        return _badRequestResponse('Failed to fetch registered user');
      }
    } else {
      return _badRequestResponse('Registration failed');
    }
  }

  String? _getUserQuery(Request request) {
    return request.url.queryParameters['user'];
  }

  Response _okResponse(dynamic body) {
    return Response.ok(jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
  }

  Response _badRequestResponse(String message) {
    return Response.badRequest(body: message);
  }

  Response _notFoundResponse(String message) {
    return Response.notFound(message);
  }

  Router get router {
    final router = Router();

    router.get('/users/get', _handleGetUser);
    router.post('/users/insert', _handleInsertUser);

    return router;
  }

  Future<void> startServer({required String host, required int port}) async {
    final handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(router.call);

    await shelf_io.serve(handler, host, port);
    print('Server running on http://$host:$port');
  }
}
