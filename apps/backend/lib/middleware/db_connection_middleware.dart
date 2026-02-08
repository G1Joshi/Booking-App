import 'dart:io';

import 'package:booking_backend/database/connection.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware dbConnection(DBConnection connection) {
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
