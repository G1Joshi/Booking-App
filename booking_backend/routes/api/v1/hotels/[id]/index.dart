import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/hotel_controller.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String id) {
  switch (context.request.method) {
    case HttpMethod.get:
      return HotelController.getById(context, id);
    case HttpMethod.put:
      return HotelController.putById(context, id);
    case HttpMethod.delete:
      return HotelController.deleteById(context, id);
    case HttpMethod.post:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
