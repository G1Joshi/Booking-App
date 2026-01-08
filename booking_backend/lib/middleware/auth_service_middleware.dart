import 'package:booking_backend/database/connection.dart';
import 'package:booking_backend/service/auth_service.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware authService(DBConnection connection) {
  return provider<AuthService>((_) {
    return AuthService(connection.getConnection);
  });
}
