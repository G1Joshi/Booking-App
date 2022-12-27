import 'package:booking_backend/models/models.dart';
import 'package:postgres/postgres.dart';

class BookingService {
  BookingService(this.connection);

  final PostgreSQLConnection connection;

  Future<void> create(Booking booking, String id) async {
    await Booking.create(connection, booking.copyWith(room_id: int.parse(id)));
  }

  Future<Booking?> read(String roomId) async {
    final booking = await Booking.read(connection, roomId);
    return booking;
  }

  Future<void> update(String roomId, Booking booking) async {
    await Booking.update(connection, booking, roomId);
  }

  Future<void> delete(String roomId) async {
    await Booking.delete(connection, roomId);
  }
}
