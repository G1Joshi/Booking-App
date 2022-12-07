import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/review_controller.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String id) {
  switch (context.request.method) {
    case HttpMethod.post:
      return ReviewController.post(context, id);
    case HttpMethod.get:
    case HttpMethod.put:
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
