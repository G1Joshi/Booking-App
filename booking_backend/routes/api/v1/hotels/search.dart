import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/hotel_controller.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  if (context.request.method == HttpMethod.get) {
    return HotelController.search(context);
  } else {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
