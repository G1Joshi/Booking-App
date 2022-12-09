import 'dart:io';

import 'package:booking_backend/models/hotels_model.dart';
import 'package:booking_backend/service/hotels_service.dart';
import 'package:dart_frog/dart_frog.dart';

class HotelController {
  static Future<Response> getAllHotels(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final hotels = await hotelService.readAll();
    return Response.json(body: hotels);
  }

  static Future<Response> addHotel(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final hotel = HotelsModel.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    return Response.json(
      statusCode: HttpStatus.created,
      body: await hotelService.create(hotel),
    );
  }

  static Future<Response> getHotel(
    RequestContext context,
    String id,
  ) async {
    final hotelService = context.read<HotelService>();
    final hotel = await hotelService.read(id);
    return Response.json(body: hotel);
  }

  static Future<Response> updateHotel(RequestContext context, String id) async {
    final hotelService = context.read<HotelService>();
    final response = await context.request.json() as Map<String, dynamic>;
    final hotel = await hotelService.read(id);
    final updatedHotel =
        Hotel.fromJson(response['hotel'] as Map<String, dynamic>);
    final updatedAddress =
        Address.fromJson(response['address'] as Map<String, dynamic>);
    final updatedContact =
        Contact.fromJson(response['contact'] as Map<String, dynamic>);

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
        details: updatedDetails.copyWith(
          id: hotel.details?.id,
          hotel_id: hotel.details?.hotel_id,
        ),
      ),
    );
    return Response.json(body: newHotel);
  }

  static Future<Response> deleteHotel(RequestContext context, String id) async {
    final hotelService = context.read<HotelService>();
    await hotelService.delete(id);
    return Response(statusCode: HttpStatus.noContent);
  }

  static Future<Response> searchHotels(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final query = context.request.uri.queryParameters;
    var hotel = <Hotel>[];
    if (query['name'] != null) {
      hotel = await hotelService.search('name', query['name']);
    } else if (query['city'] != null) {
      hotel = await hotelService.search('city', query['city']);
    } else if (query['country'] != null) {
      hotel = await hotelService.search('country', query['country']);
    } else if (query['category'] != null) {
      hotel = await hotelService.search('category', query['category']);
    } else if (query['property_type'] != null) {
      hotel =
          await hotelService.search('property_type', query['property_type']);
    } else if (query['locality'] != null) {
      final distance = int.tryParse(query['distance'] ?? '10') ?? 10;
      hotel = await hotelService.searchByLocality(query['locality'], distance);
    } else if (query['rating'] != null) {
      final rating = num.tryParse(query['rating'] ?? '0') ?? 0;
      hotel = await hotelService.searchByRating(rating);
    } else if (query['checkin'] != null && query['checkout'] != null) {
      final rooms = int.tryParse(query['rooms'] ?? '0') ?? 0;
      hotel = await hotelService.searchByDate(
        query['checkin'].toString(),
        query['checkout'].toString(),
        rooms,
      );
    }
    return Response.json(body: hotel);
  }
}
