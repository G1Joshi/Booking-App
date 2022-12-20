import 'dart:io';

import 'package:booking_backend/models/general_response.dart';
import 'package:booking_backend/models/hotels_model.dart';
import 'package:booking_backend/service/hotels_service.dart';
import 'package:dart_frog/dart_frog.dart';

class HotelController {
  static Future<Response> getAllHotels(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final hotels = await hotelService.readAll();
    return Response.json(
      body: GeneralResponse(
        status: true,
        data: hotels,
      ),
    );
  }

  static Future<Response> addHotel(RequestContext context) async {
    final hotelService = context.read<HotelService>();
    final hotel = HotelsModel.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
        data: await hotelService.create(hotel),
      ),
    );
  }

  static Future<Response> getHotel(
    RequestContext context,
    String id,
  ) async {
    final hotelService = context.read<HotelService>();
    final hotel = await hotelService.read(id);
    return Response.json(
      body: GeneralResponse(
        status: true,
        data: hotel,
      ),
    );
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
    return Response.json(
      body: GeneralResponse(
        status: true,
        data: newHotel,
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
    var hotel = <Hotel>[];
    hotel = await hotelService.search(
      query['locality'].toString(),
      int.tryParse(query['distance'] ?? '10') ?? 10,
      query['checkin'].toString(),
      query['checkout'].toString(),
      int.tryParse(query['rooms'] ?? '0') ?? 0,
    );
    return Response.json(
      body: GeneralResponse(
        status: true,
        data: hotel,
      ),
    );
  }
}
