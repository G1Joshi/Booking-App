import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/hotel_controller.dart';
import 'package:booking_backend/models/general_response.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  if (context.request.method == HttpMethod.get) {
    return HotelController.filterHotels(context);
  } else {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: GeneralResponse(
        status: false,
        message: 'Method not allowed',
      ),
    );
  }
}
