import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/booking_controller.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String hotelId,
  String roomId,
  String bookingId,
) {
  switch (context.request.method) {
    case HttpMethod.put:
      return BookingController.updateBooking(context, roomId, bookingId);
    case HttpMethod.delete:
      return BookingController.deleteBooking(context, roomId, bookingId);
    case HttpMethod.get:
    case HttpMethod.post:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response.json(
        statusCode: HttpStatus.methodNotAllowed,
        body: const GeneralResponse(
          status: false,
        ),
      );
  }
}
