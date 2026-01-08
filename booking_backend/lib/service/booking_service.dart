import 'package:booking_backend/models/models.dart';
import 'package:postgres/postgres.dart';

class BookingService {
  BookingService(this.connection);

  final Connection connection;

  Future<void> create(Booking booking, String roomId, String userId) async {
    await Booking.create(
      connection,
      booking.copyWith(room_id: int.parse(roomId), user_id: userId),
    );
  }

  Future<Booking?> read(String roomId, String bookingId) async {
    final booking = await Booking.read(connection, roomId, bookingId);
    return booking;
  }

  Future<void> update(String roomId, String bookingId, Booking booking) async {
    await Booking.update(connection, booking, roomId, bookingId);
  }

  Future<void> delete(String roomId, String bookingId) async {
    await Booking.delete(connection, roomId, bookingId);
  }
}
