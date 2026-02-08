import 'dart:async';
import 'dart:io';

import 'package:booking_backend/controller/room_controller.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String hotelId,
  String roomId,
) {
  switch (context.request.method) {
    case HttpMethod.delete:
      return RoomController.deleteRoom(context, hotelId, roomId);
    case HttpMethod.put:
      return RoomController.updateRoom(context, hotelId, roomId);
    case HttpMethod.post:
    case HttpMethod.get:
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
