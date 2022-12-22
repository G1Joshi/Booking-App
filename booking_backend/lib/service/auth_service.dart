import 'package:booking_backend/models/token_model.dart';
import 'package:booking_backend/models/user_model.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:googleapis/oauth2/v2.dart';
import 'package:http/http.dart' as http;
import 'package:postgres/postgres.dart';

class AuthService {
  AuthService(this.connection);

  final PostgreSQLConnection connection;
  final env = DotEnv()..load();

  bool _isAdmin(Map<String, String> headers) {
    if (headers.containsKey('X-Secret-Key')) {
      return headers['X-Secret-Key'] == env['secretKey'];
    }
    return false;
  }

  String? _getToken(Map<String, String> headers) {
    String? token;
    if (headers.containsKey('Authorization')) {
      final header = headers['Authorization'].toString().split(' ');
      if (header[0].contains('Bearer')) {
        token = header[1];
      } else {
        token = header[0];
      }
    }
    return token;
  }

  Future<bool> create(Request request) async {
    final user = User.fromJson(
      await request.json() as Map<String, dynamic>,
    );
    final userExists = await User.checkAccount(connection, user.id);
    if (userExists) return false;
    await User.create(connection, user);
    return true;
  }

  Future<bool> read(Request request) async {
    final token = Token.fromJson(
      await request.json() as Map<String, dynamic>,
    );
    final oAuth = Oauth2Api(http.Client());
    final tokenInfo = await oAuth.tokeninfo(idToken: token.id_token);
    final userExists = await User.checkAccount(connection, tokenInfo.userId!);
    if (!userExists) return false;
    return !(tokenInfo.audience != env['clientId'] ||
        tokenInfo.issuedTo != env['clientId']);
  }

  Future<bool> verify(Map<String, String> headers) async {
    if (_isAdmin(headers)) return true;
    final accessToken = _getToken(headers);
    final oAuth = Oauth2Api(http.Client());
    final tokenInfo = await oAuth.tokeninfo(accessToken: accessToken);
    return !(tokenInfo.audience != env['clientId'] ||
        tokenInfo.issuedTo != env['clientId']);
  }

  Future<String> getUserID(Map<String, String> headers) async {
    final accessToken = _getToken(headers);
    final oAuth = Oauth2Api(http.Client());
    final tokenInfo = await oAuth.tokeninfo(accessToken: accessToken);
    return tokenInfo.userId!;
  }

  Future<User> getUser(Map<String, String> headers) async {
    final user = await User.read(connection, await getUserID(headers));
    return user;
  }
}
