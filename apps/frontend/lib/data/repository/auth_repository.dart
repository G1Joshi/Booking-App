import 'package:booking_frontend/data/data.dart';
import 'package:booking_models/booking_models.dart';
import 'package:booking_utils/booking_utils.dart';

class AuthRepository {
  AuthRepository({Client? client}) : _client = client ?? Client();

  final Client _client;

  Future<bool> signUp(User user) async {
    final response = await _client.post(
      path: AuthApi.signup,
      data: user.toJson(),
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return data.status;
    } else {
      throw Exception(data.message);
    }
  }

  Future<Token?> signIn(LoginRequest request) async {
    final response = await _client.post(
      path: AuthApi.signin,
      data: request.toJson(),
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = Token.fromJson((data.data as Map<String, dynamic>?) ?? {});
      return result;
    } else {
      throw Exception(data.message);
    }
  }
}
