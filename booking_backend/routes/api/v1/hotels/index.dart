import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/hotel_controller.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  switch (context.request.method) {
    case HttpMethod.get:
      return HotelController.get(context);
    case HttpMethod.post:
      return HotelController.post(context);
    case HttpMethod.put:
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
