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
    final tokenInfo = await oAuth.tokeninfo(
      accessToken: token.access_token,
      idToken: token.id_token,
    );
    final userExists = await User.checkAccount(connection, tokenInfo.userId!);
    if (!userExists) return false;
    return !(tokenInfo.audience != env['clientId'] ||
        tokenInfo.issuedTo != env['clientId']);
  }
}
