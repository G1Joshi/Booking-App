import 'package:booking_backend/database/extensions.dart';
import 'package:booking_models/booking_models.dart';
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
    // TODO(auth): Implement JWT
    return const Uuid().v4();
  }

  Future<bool> create(User user) async {
    final accessToken = await UserDb.checkAccount(
      connection,
      user.email,
      user.password,
    );
    if (accessToken != null) return false;
    final result = await UserDb.create(
      connection,
      user.copyWith(accessToken: _getAccessToken()),
    );
    return result;
  }

  Future<Token?> read(LoginRequest token) async {
    final accessToken = await UserDb.checkAccount(
      connection,
      token.email,
      token.password,
    );
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
    final userId = await UserDb.getUserId(connection, accessToken!);
    return userId;
  }

  Future<User> getUser(Map<String, String> headers) async {
    final user = await UserDb.read(connection, await getUserID(headers));
    return user;
  }
}
