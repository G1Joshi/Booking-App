import 'package:booking_backend/database/extensions.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class RoomService {
  RoomService(this.connection);

  final Connection connection;

  Future<void> create(Room room, String hotelId) async {
    await RoomDb.create(connection, room.copyWith(hotelId: int.parse(hotelId)));
  }

  Future<Room?> read(String hotelId, String roomId) async {
    final room = await RoomDb.read(connection, hotelId, roomId);
    return room;
  }

  Future<void> update(String hotelId, String roomId, Room room) async {
    await RoomDb.update(connection, room, hotelId, roomId);
  }

  Future<void> delete(String hotelId, String roomId) async {
    await RoomDb.delete(connection, hotelId, roomId);
  }
}
