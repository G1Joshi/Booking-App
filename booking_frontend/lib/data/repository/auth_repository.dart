import 'package:booking_frontend/config/config.dart';
import 'package:booking_frontend/data/data.dart';

class AuthRepository {
  Future<bool> signUp(User user) async {
    final response = await Client().post(
      path: signupPath,
      data: user.toJson(),
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return data.status;
    } else {
      throw Exception(data.message);
    }
  }

  Future<bool> signIn(Token token) async {
    final response = await Client().post(
      path: signinPath,
      data: token.toJson(),
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return data.status;
    } else {
      throw Exception(data.message);
    }
  }
}
