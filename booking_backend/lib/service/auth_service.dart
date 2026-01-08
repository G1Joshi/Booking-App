import 'package:booking_backend/models/login_request.dart';
import 'package:booking_backend/models/models.dart';
import 'package:booking_backend/models/token_model.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  AuthService(this.connection);

  final Connection connection;

  bool _isAdmin(Map<String, String> headers) {
    if (headers.containsKey('X-Secret-Key')) {
      return headers['X-Secret-Key'] == 'Admin';
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

  String _getAccessToken() {
    // TODO: JWT
    return const Uuid().v4();
  }

  Future<bool> create(User user) async {
    final accessToken =
        await User.checkAccount(connection, user.email, user.password);
    if (accessToken != null) return false;
    final result = await User.create(
      connection,
      user.copyWith(access_token: _getAccessToken()),
    );
    return result;
  }

  Future<Token?> read(LoginRequest token) async {
    final accessToken =
        await User.checkAccount(connection, token.email, token.password);
    if (accessToken != null) {
      return Token(accessToken: accessToken);
    }
    return null;
  }

  Future<bool> verify(Map<String, String> headers) async {
    if (_isAdmin(headers)) return true;
    final userId = await getUserID(headers);
    return userId.isNotEmpty;
  }

  Future<String> getUserID(Map<String, String> headers) async {
    final accessToken = _getToken(headers);
    final userId = await User.getUserId(connection, accessToken!);
    return userId;
  }

  Future<User> getUser(Map<String, String> headers) async {
    final user = await User.read(connection, await getUserID(headers));
    return user;
  }
}
