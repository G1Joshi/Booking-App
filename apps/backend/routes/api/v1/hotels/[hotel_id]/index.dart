import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/hotel_controller.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String hotelId) {
  switch (context.request.method) {
    case HttpMethod.get:
      return HotelController.getHotel(context, hotelId);
    case HttpMethod.put:
      return HotelController.updateHotel(context, hotelId);
    case HttpMethod.delete:
      return HotelController.deleteHotel(context, hotelId);
    case HttpMethod.post:
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
