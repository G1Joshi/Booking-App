import 'dart:io';

import 'package:booking_backend/controller/auth_controller.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware tokenVerification() {
  return (handler) {
    return (context) async {
      final isVerified = await AuthController.verify(context);
      if (isVerified) {
        final response = await handler(context);
        return response;
      } else {
        return Response.json(
          statusCode: HttpStatus.unauthorized,
          body: const GeneralResponse(
            status: false,
            message: 'Unauthorized',
          ),
        );
      }
    };
  };
}
