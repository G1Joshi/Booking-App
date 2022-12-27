import 'package:booking_backend/models/models.dart';
import 'package:booking_backend/models/token_model.dart';
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

  Future<bool> create(User user) async {
    final userExists = await User.checkAccount(connection, user.id);
    if (userExists) return false;
    await User.create(connection, user);
    return true;
  }

  Future<bool> read(Token token) async {
    final oAuth = Oauth2Api(http.Client());
    final tokenInfo = await oAuth.tokeninfo(idToken: token.idToken);
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
