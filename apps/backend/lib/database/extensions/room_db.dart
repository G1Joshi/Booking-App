import 'package:booking_backend/database/query_helper.dart';
import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class RoomDb {
  static final _crud = CrudDb<Room>(
    table: Tables.rooms,
    fromJson: Room.fromJson,
    toJson: _toJson,
  );

  static Map<String, dynamic> _toJson(Room data) => data.toJson();

  static Future<void> create(Connection connection, Room? data) =>
      _crud.create(connection, data);

  static Future<Room> read(
    Connection connection,
    String hotelId,
    String roomId,
  ) => _crud.readBy(connection, {
    'hotel_id': hotelId,
    'id': roomId,
  });

  static Future<List<Room>> readAll(Connection connection, String id) =>
      _crud.readAll(connection, id);

  static Future<void> update(
    Connection connection,
    Room? data,
    String hotelId,
    String roomId,
  ) => _crud.updateBy(connection, data, {
    'hotel_id': hotelId,
    'id': roomId,
  });

  static Future<void> delete(
    Connection connection,
    String hotelId,
    String roomId,
  ) => _crud.deleteBy(connection, {
    'hotel_id': hotelId,
    'id': roomId,
  });

  static Future<void> deleteAll(Connection connection, String id) =>
      _crud.delete(connection, id);
}
