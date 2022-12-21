import 'package:booking_backend/models/hotels_model.dart';
import 'package:postgres/postgres.dart';

class RoomService {
  RoomService(this.connection);

  final PostgreSQLConnection connection;

  Future<Room> create(Room room, String hotelId) async {
    await Room.create(connection, room.copyWith(hotel_id: int.parse(hotelId)));
    return room;
  }

  Future<Room?> read(String hotelId, String roomId) async {
    final room = await Room.read(connection, hotelId, roomId);
    return room;
  }

  Future<Room> update(String hotelId, String roomId, Room room) async {
    await Room.update(connection, room, hotelId, roomId);
    return room;
  }

  Future<void> delete(String hotelId, String roomId) async {
    await Room.delete(connection, hotelId, roomId);
  }
}
