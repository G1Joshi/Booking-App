import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/review_controller.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String hotelId,
  String reviewId,
) {
  switch (context.request.method) {
    case HttpMethod.delete:
      return ReviewController.deleteReview(context, hotelId, reviewId);
    case HttpMethod.put:
      return ReviewController.updateReview(context, hotelId, reviewId);
    case HttpMethod.post:
    case HttpMethod.get:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
