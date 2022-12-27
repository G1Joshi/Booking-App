import 'dart:io';

import 'package:booking_backend/models/general_response.dart';
import 'package:booking_backend/models/models.dart';
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
    await bookingService.create(booking, roomId);
    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
      ),
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
    await bookingService.update(
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
    return Response.json(
      body: GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> deleteBooking(
    RequestContext context,
    String roomId,
  ) async {
    final bookingService = context.read<BookingService>();
    await bookingService.delete(roomId);
    return Response.json(
      statusCode: HttpStatus.noContent,
      body: GeneralResponse(
        status: true,
      ),
    );
  }
}
