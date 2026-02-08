import 'package:booking_backend/database/extensions.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class BookingService {
  BookingService(this.connection);

  final Connection connection;

  Future<void> create(Booking booking, String roomId, String userId) async {
    await BookingDb.create(
      connection,
      booking.copyWith(roomId: int.parse(roomId), userId: userId),
    );
  }

  Future<Booking?> read(String roomId, String bookingId) async {
    final booking = await BookingDb.read(connection, roomId, bookingId);
    return booking;
  }

  Future<void> update(String roomId, String bookingId, Booking booking) async {
    await BookingDb.update(connection, booking, roomId, bookingId);
  }

  Future<void> delete(String roomId, String bookingId) async {
    await BookingDb.delete(connection, roomId, bookingId);
  }
}
