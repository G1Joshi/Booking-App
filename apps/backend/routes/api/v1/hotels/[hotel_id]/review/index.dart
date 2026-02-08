import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/review_controller.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String hotelId) {
  switch (context.request.method) {
    case HttpMethod.post:
      return ReviewController.addReview(context, hotelId);
    case HttpMethod.get:
    case HttpMethod.put:
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response.json(
        statusCode: HttpStatus.methodNotAllowed,
        body: const GeneralResponse(
          status: false,
          message: 'Method not allowed',
        ),
      );
  }
}
