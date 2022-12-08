import 'dart:io';

import 'package:booking_backend/models/hotels_model.dart';
import 'package:booking_backend/service/room_service.dart';
import 'package:dart_frog/dart_frog.dart';

class RoomController {
  static Future<Response> addRoom(RequestContext context, String id) async {
    final roomService = context.read<RoomService>();
    final room = Room.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    return Response.json(
      statusCode: HttpStatus.created,
      body: await roomService.create(room, id),
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
    final newRoom = await roomService.update(
      hotelId,
      roomId,
      room!.copyWith(
        category: updatedRoom.category,
        description: updatedRoom.description,
        price: updatedRoom.price,
        count: updatedRoom.count,
        occupancy: updatedRoom.occupancy,
        amenities: updatedRoom.amenities,
        room_images: updatedRoom.room_images,
      ),
    );
    return Response.json(body: newRoom);
  }

  static Future<Response> deleteRoom(
    RequestContext context,
    String hotelId,
    String roomId,
  ) async {
    final rooomService = context.read<RoomService>();
    await rooomService.delete(hotelId, roomId);
    return Response(statusCode: HttpStatus.noContent);
  }
}
