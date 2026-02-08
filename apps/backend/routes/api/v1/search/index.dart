import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/hotel_controller.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  if (context.request.method == HttpMethod.get) {
    return HotelController.searchHotels(context);
  } else {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: const GeneralResponse(
        status: false,
        message: 'Method not allowed',
      ),
    );
  }
}
