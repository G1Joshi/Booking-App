import 'package:booking_backend/database/query_helper.dart';
import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class BookingDb {
  static final _crud = CrudDb<Booking>(
    table: Tables.bookings,
    fromJson: Booking.fromJson,
    toJson: _toJson,
    primaryKey: 'room_id',
  );

  static Map<String, dynamic> _toJson(Booking data) => data.toJson();

  static Future<void> create(Connection connection, Booking? data) =>
      _crud.create(connection, data);

  static Future<Booking> read(
    Connection connection,
    String roomId,
    String bookingId,
  ) => _crud.readBy(connection, {
    'room_id': roomId,
    'id': bookingId,
  });

  static Future<Booking> readAll(Connection connection, String id) async {
    final result = await _crud.readAll(connection, id);
    return result.first;
  }

  static Future<void> update(
    Connection connection,
    Booking? data,
    String roomId,
    String bookingId,
  ) => _crud.updateBy(connection, data, {
    'room_id': roomId,
    'id': bookingId,
  });

  static Future<void> delete(
    Connection connection,
    String roomId,
    String bookingId,
  ) => _crud.deleteBy(connection, {
    'room_id': roomId,
    'id': bookingId,
  });

  static Future<void> deleteAll(Connection connection, String roomId) =>
      _crud.delete(connection, roomId);
}
