import 'dart:io';

import 'package:booking_backend/models/hotels_model.dart';
import 'package:booking_backend/service/hotels_service.dart';
import 'package:dart_frog/dart_frog.dart';

class RoomController {
  static Future<Response> post(RequestContext context, String id) async {
    final hotelService = context.read<HotelService>();
    final room = Room.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    return Response.json(
      statusCode: HttpStatus.created,
      body: await hotelService.addRoom(room, id),
    );
  }
}
