import 'dart:io';

import 'package:booking_backend/models.dart/hotel_model.dart';
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
    final hotel = Hotel.fromJson(
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
    final hotel = await hotelService.read(id);
    final updatedHotel = Hotel.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    final newHotel = await hotelService.update(
      id,
      hotel!.copyWith(
        name: updatedHotel.name,
        phone: updatedHotel.phone,
        email: updatedHotel.email,
        address: updatedHotel.address,
        pincode: updatedHotel.pincode,
        city: updatedHotel.city,
        country: updatedHotel.country,
        rooms: updatedHotel.rooms,
        rating: updatedHotel.rating,
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
    if (query['name'] != null) {
      hotel = await hotelService.search('name', query['name']);
    } else if (query['city'] != null) {
      hotel = await hotelService.search('city', query['city']);
    } else if (query['country'] != null) {
      hotel = await hotelService.search('country', query['country']);
    }
    return Response.json(body: hotel);
  }
}
