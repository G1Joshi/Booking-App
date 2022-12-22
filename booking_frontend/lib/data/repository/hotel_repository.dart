import 'package:booking_frontend/config/config.dart';
import 'package:booking_frontend/data/data.dart';

class HotelRepository {
  Future<List<Hotel>> readAll() async {
    final response = await Client().get(path: hotelsPath);
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = List<Hotel>.from(
        (data.data as Iterable?)!
            .map((e) => Hotel.fromJson(e as Map<String, dynamic>)),
      );
      return result;
    } else {
      throw Exception(data.message);
    }
  }

  Future<HotelDetails> read(int id) async {
    final response = await Client().get(path: '$hotelsPath/$id');
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result =
          HotelDetails.fromJson((data.data as Map<String, dynamic>?) ?? {});
      return result;
    } else {
      throw Exception(data.message);
    }
  }

  Future<List<Hotel>> search(
    String locality,
    int distance,
    String checkin,
    String checkout,
    int rooms,
  ) async {
    final queryParameters = {
      'locality': locality,
      'distance': distance,
      'checkin': checkin,
      'checkout': checkout,
      'rooms': rooms,
    };
    final response =
        await Client().get(path: searchPath, queryParameters: queryParameters);
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = List<Hotel>.from(
        (data.data as Iterable?)!
            .map((e) => Hotel.fromJson(e as Map<String, dynamic>)),
      );
      return result;
    } else {
      throw Exception(data.message);
    }
  }

  Future<List<Hotel>> filter(
    String star,
    String rating,
    String propertyType,
    String budget,
  ) async {
    final queryParameters = {
      if (star != '') 'star': star,
      if (rating != '') 'rating': rating,
      if (propertyType != '') 'property_type': propertyType,
      if (budget != '') 'budget': budget,
    };
    final response =
        await Client().get(path: filterPath, queryParameters: queryParameters);
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = List<Hotel>.from(
        (data.data as Iterable?)!
            .map((e) => Hotel.fromJson(e as Map<String, dynamic>)),
      );
      return result;
    } else {
      throw Exception(data.message);
    }
  }

  Future<bool> addReview(
    int hotelId,
    double rating,
    String review,
  ) async {
    final response = await Client().post(
      path: '$hotelsPath/$hotelId/$reviewPath',
      data: {
        'rating': rating,
        'review': review,
      },
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return data.status;
    } else {
      throw Exception(data.message);
    }
  }

  Future<bool> deleteReview(int hotelId, int reviewId) async {
    final response = await Client().delete(
      path: '$hotelsPath/$hotelId/$reviewPath/$reviewId',
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return data.status;
    } else {
      throw Exception(data.message);
    }
  }
}
