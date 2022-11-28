import 'package:booking_backend/database/connection.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware dbConnection() {
  return (handler) {
    return (context) async {
      await Connection().connect;
      final response = await handler(context);
      await Connection().disconnect;
      return response;
    };
  };
}
