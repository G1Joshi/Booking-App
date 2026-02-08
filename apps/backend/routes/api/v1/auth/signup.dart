import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/auth_controller.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  if (context.request.method == HttpMethod.post) {
    return AuthController.signUp(context);
  } else {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: const GeneralResponse(
        status: false,
        message: 'Method not allowed',
      ),
    );
  }
}
