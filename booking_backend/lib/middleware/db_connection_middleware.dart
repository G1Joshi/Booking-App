import 'package:booking_backend/database/connection.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware dbConnection(Connection connection) {
  return (handler) {
    return (context) async {
      await connection.connect;
      final response = await handler(context);
      await connection.disconnect;
      return response;
    };
  };
}
