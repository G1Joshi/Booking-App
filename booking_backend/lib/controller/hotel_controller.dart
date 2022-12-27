import 'dart:io';

import 'package:booking_backend/models/general_response.dart';
import 'package:booking_backend/models/models.dart';
import 'package:booking_backend/service/hotels_service.dart';
import 'package:dart_frog/dart_frog.dart';

class HotelController {
  static Future<Response> getAllHotels(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final data = await hotelService.readAll();
    return Response.json(
      body: GeneralResponse(
        status: true,
        data: data.map((e) => e.toDatabase()).toList(),
      ),
    );
  }

  static Future<Response> addHotel(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final hotel = Hotel.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await hotelService.create(hotel);
    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> getHotel(
    RequestContext context,
    String id,
  ) async {
    final hotelService = context.read<HotelService>();
    final data = await hotelService.read(id);
    return Response.json(
      body: GeneralResponse(
        status: true,
        data: data,
      ),
    );
  }

  static Future<Response> updateHotel(RequestContext context, String id) async {
    final hotelService = context.read<HotelService>();
    final response = await context.request.json() as Map<String, dynamic>;
    final hotel = await hotelService.read(id);
    final updatedHotel = Hotel.fromJson(response);
    final updatedAddress =
        Address.fromJson(response['address'] as Map<String, dynamic>);
    final updatedContact =
        Contact.fromJson(response['contact'] as Map<String, dynamic>);
    final updatedDetails =
        Details.fromJson(response['details'] as Map<String, dynamic>);
    await hotelService.update(
      int.parse(id),
      hotel!.copyWith(
        id: updatedHotel.id,
        name: updatedHotel.name,
        description: updatedHotel.description,
        property_type: updatedHotel.property_type,
        chain: updatedHotel.chain,
        star: updatedHotel.star,
        rating: updatedHotel.rating,
        rooms_starting_price: updatedHotel.rooms_starting_price,
        cover_image: updatedHotel.cover_image,
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
    return Response.json(
      body: GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> deleteHotel(RequestContext context, String id) async {
    final hotelService = context.read<HotelService>();
    await hotelService.delete(id);
    return Response.json(
      statusCode: HttpStatus.noContent,
      body: GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> searchHotels(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final query = context.request.uri.queryParameters;
    var data = <Hotel>[];
    data = await hotelService.search(
      query['locality'].toString(),
      int.tryParse(query['distance'] ?? '10') ?? 10,
      query['checkin'].toString(),
      query['checkout'].toString(),
      int.tryParse(query['rooms'] ?? '0') ?? 0,
    );
    return Response.json(
      body: GeneralResponse(
        status: true,
        data: data,
      ),
    );
  }

  static Future<Response> filterHotels(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final query = context.request.uri.queryParameters;
    var data = <Hotel>[];
    data = await hotelService.filter(
      query['star'],
      query['rating'],
      query['property_type'],
      query['budget'],
    );
    return Response.json(
      body: GeneralResponse(
        status: true,
        data: data,
      ),
    );
  }
}
