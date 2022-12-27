import 'package:booking_backend/models/models.dart';
import 'package:postgres/postgres.dart';

class RoomService {
  RoomService(this.connection);

  final PostgreSQLConnection connection;

  Future<void> create(Room room, String hotelId) async {
    await Room.create(connection, room.copyWith(hotel_id: int.parse(hotelId)));
  }

  Future<Room?> read(String hotelId, String roomId) async {
    final room = await Room.read(connection, hotelId, roomId);
    return room;
  }

  Future<void> update(String hotelId, String roomId, Room room) async {
    await Room.update(connection, room, hotelId, roomId);
  }

  Future<void> delete(String hotelId, String roomId) async {
    await Room.delete(connection, hotelId, roomId);
  }
}
