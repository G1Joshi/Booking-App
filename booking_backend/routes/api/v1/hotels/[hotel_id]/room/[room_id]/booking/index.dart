import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/booking_controller.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String hotelId,
  String roomId,
) {
  switch (context.request.method) {
    case HttpMethod.post:
      return BookingController.addBooking(context, roomId);
    case HttpMethod.put:
      return BookingController.updateBooking(context, roomId);
    case HttpMethod.delete:
      return BookingController.deleteBooking(context, roomId);
    case HttpMethod.get:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
