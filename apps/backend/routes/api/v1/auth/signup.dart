import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/auth_controller.dart';
import 'package:booking_backend/models/general_response.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  if (context.request.method == HttpMethod.post) {
    return AuthController.signUp(context);
  } else {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: GeneralResponse(
        status: false,
        message: 'Method not allowed',
      ),
    );
  }
}
