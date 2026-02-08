import 'dart:io';

import 'package:booking_backend/service/auth_service.dart';
import 'package:booking_backend/service/booking_service.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

class BookingController {
  static Future<Response> addBooking(
    RequestContext context,
    String roomId,
  ) async {
    final authService = context.read<AuthService>();
    final bookingService = context.read<BookingService>();
    final userId = await authService.getUserID(context.request.headers);
    final booking = Booking.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await bookingService.create(booking, roomId, userId);
    return Response.json(
      statusCode: HttpStatus.created,
      body: const GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> updateBooking(
    RequestContext context,
    String roomId,
    String bookingId,
  ) async {
    final bookingService = context.read<BookingService>();
    final booking = await bookingService.read(roomId, bookingId);
    final updatedBooking = Booking.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await bookingService.update(
      roomId,
      bookingId,
      booking!.copyWith(
        checkin: updatedBooking.checkin,
        checkout: updatedBooking.checkout,
        guests: updatedBooking.guests,
        rooms: updatedBooking.rooms,
      ),
    );
    return Response.json(
      body: const GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> deleteBooking(
    RequestContext context,
    String roomId,
    String bookingId,
  ) async {
    final bookingService = context.read<BookingService>();
    await bookingService.delete(roomId, bookingId);
    return Response.json(
      body: const GeneralResponse(
        status: true,
      ),
    );
  }
}
