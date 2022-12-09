import 'dart:io';

import 'package:booking_backend/models/hotels_model.dart';
import 'package:booking_backend/service/booking_service.dart';
import 'package:dart_frog/dart_frog.dart';

class BookingController {
  static Future<Response> addBooking(
    RequestContext context,
    String roomId,
  ) async {
    final bookingService = context.read<BookingService>();
    final booking = Booking.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    return Response.json(
      statusCode: HttpStatus.created,
      body: await bookingService.create(booking, roomId),
    );
  }

  static Future<Response> updateBooking(
    RequestContext context,
    String roomId,
  ) async {
    final bookingService = context.read<BookingService>();
    final booking = await bookingService.read(roomId);
    final updatedBooking = Booking.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    final newBooking = await bookingService.update(
      roomId,
      booking!.copyWith(
        name: updatedBooking.name,
        checkin: updatedBooking.checkin,
        checkout: updatedBooking.checkout,
        adults: updatedBooking.adults,
        children: updatedBooking.children,
        rooms: updatedBooking.rooms,
      ),
    );
    return Response.json(body: newBooking);
  }

  static Future<Response> deleteBooking(
    RequestContext context,
    String roomId,
  ) async {
    final bookingService = context.read<BookingService>();
    await bookingService.delete(roomId);
    return Response(statusCode: HttpStatus.noContent);
  }
}
