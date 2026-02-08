import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/hotel_controller.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  switch (context.request.method) {
    case HttpMethod.get:
      return HotelController.getAllHotels(context);
    case HttpMethod.post:
      return HotelController.addHotel(context);
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
