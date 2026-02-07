import 'dart:io';

import 'package:booking_backend/models/general_response.dart';
import 'package:booking_backend/models/models.dart';
import 'package:booking_backend/service/room_service.dart';
import 'package:dart_frog/dart_frog.dart';

class RoomController {
  static Future<Response> addRoom(RequestContext context, String id) async {
    final roomService = context.read<RoomService>();
    final room = Room.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await roomService.create(room, id);
    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> updateRoom(
    RequestContext context,
    String hotelId,
    String roomId,
  ) async {
    final roomService = context.read<RoomService>();
    final room = await roomService.read(hotelId, roomId);
    final updatedRoom = Room.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await roomService.update(
      hotelId,
      roomId,
      room!.copyWith(
        category: updatedRoom.category,
        description: updatedRoom.description,
        price: updatedRoom.price,
        count: updatedRoom.count,
        capacity: updatedRoom.capacity,
        amenities: updatedRoom.amenities,
        room_images: updatedRoom.room_images,
      ),
    );
    return Response.json(
      body: GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> deleteRoom(
    RequestContext context,
    String hotelId,
    String roomId,
  ) async {
    final rooomService = context.read<RoomService>();
    await rooomService.delete(hotelId, roomId);
    return Response.json(
      statusCode: HttpStatus.noContent,
      body: GeneralResponse(
        status: true,
      ),
    );
  }
}
