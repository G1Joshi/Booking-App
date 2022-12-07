import 'dart:io';

import 'package:booking_backend/models/hotels_model.dart';
import 'package:booking_backend/service/hotels_service.dart';
import 'package:dart_frog/dart_frog.dart';

class HotelController {
  static Future<Response> get(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final hotels = await hotelService.readAll();
    return Response.json(body: hotels);
  }

  static Future<Response> post(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final hotel = HotelModel.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    return Response.json(
      statusCode: HttpStatus.created,
      body: await hotelService.create(hotel),
    );
  }

  static Future<Response> getById(RequestContext context, String id) async {
    final hotelService = context.read<HotelService>();
    final hotel = await hotelService.read(id);
    return Response.json(body: hotel);
  }

  static Future<Response> putById(RequestContext context, String id) async {
    final hotelService = context.read<HotelService>();
    final response = await context.request.json() as Map<String, dynamic>;
    final hotel = await hotelService.read(id);
    final updatedHotel =
        Hotel.fromJson(response['hotel'] as Map<String, dynamic>);
    final updatedAddress =
        Address.fromJson(response['address'] as Map<String, dynamic>);
    final updatedContact =
        Contact.fromJson(response['contact'] as Map<String, dynamic>);
    final updatedBooking =
        Booking.fromJson(response['booking'] as Map<String, dynamic>);
    final updatedDetails =
        Details.fromJson(response['details'] as Map<String, dynamic>);
    final newHotel = await hotelService.update(
      int.parse(id),
      hotel!.copyWith(
        hotel: updatedHotel.copyWith(id: hotel.hotel?.id),
        address: updatedAddress.copyWith(
          id: hotel.address?.id,
          hotel_id: hotel.address?.hotel_id,
        ),
        contact: updatedContact.copyWith(
          id: hotel.contact?.id,
          hotel_id: hotel.contact?.hotel_id,
        ),
        booking: updatedBooking.copyWith(
          id: hotel.booking?.id,
          hotel_id: hotel.booking?.hotel_id,
        ),
        details: updatedDetails.copyWith(
          id: hotel.details?.id,
          hotel_id: hotel.details?.hotel_id,
        ),
      ),
    );
    return Response.json(body: newHotel);
  }

  static Future<Response> deleteById(RequestContext context, String id) async {
    final hotelService = context.read<HotelService>();
    await hotelService.delete(id);
    return Response(statusCode: HttpStatus.noContent);
  }

  static Future<Response> search(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final query = context.request.uri.queryParameters;
    var hotel = <Hotel>[];
    if (query['locality'] != null) {
      final distance = int.tryParse(query['distance'] ?? '10') ?? 10;
      hotel = await hotelService.searchByLocality(query['locality'], distance);
    } else if (query['name'] != null) {
      hotel = await hotelService.search('name', query['name']);
    } else if (query['city'] != null) {
      hotel = await hotelService.search('city', query['city']);
    } else if (query['country'] != null) {
      hotel = await hotelService.search('country', query['country']);
    }
    return Response.json(body: hotel);
  }
}
