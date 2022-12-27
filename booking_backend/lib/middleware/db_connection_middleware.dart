import 'dart:io';

import 'package:booking_backend/database/connection.dart';
import 'package:booking_backend/models/general_response.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware dbConnection(Connection connection) {
  return (handler) {
    return (context) async {
      try {
        await connection.connect;
        final response = await handler(context);
        await connection.disconnect;
        return response;
      } catch (e) {
        return Response.json(
          statusCode: HttpStatus.badRequest,
          body: GeneralResponse(
            status: false,
            message: '$e',
          ),
        );
      }
    };
  };
}
