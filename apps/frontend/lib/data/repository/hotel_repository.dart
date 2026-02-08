import 'package:booking_frontend/data/data.dart';
import 'package:booking_models/booking_models.dart';
import 'package:booking_utils/booking_utils.dart';

class HotelRepository {
  HotelRepository({Client? client}) : _client = client ?? Client();

  final Client _client;

  Future<List<Hotel>> readAll() async {
    final response = await _client.get(path: HotelsApi.base);
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = List<Hotel>.from(
        (data.data as Iterable?)!.map(
          (e) => Hotel.fromJson(e as Map<String, dynamic>),
        ),
      );
      return result;
    } else {
      throw Exception(data.message);
    }
  }

  Future<Hotel> read(int id) async {
    final response = await _client.get(path: '${HotelsApi.base}/$id');
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = Hotel.fromJson((data.data as Map<String, dynamic>?) ?? {});
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
    final response = await _client.get(
      path: SearchApi.base,
      queryParameters: queryParameters,
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = List<Hotel>.from(
        (data.data as Iterable?)!.map(
          (e) => Hotel.fromJson(e as Map<String, dynamic>),
        ),
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
    final response = await _client.get(
      path: FilterApi.base,
      queryParameters: queryParameters,
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      final result = List<Hotel>.from(
        (data.data as Iterable?)!.map(
          (e) => Hotel.fromJson(e as Map<String, dynamic>),
        ),
      );
      return result;
    } else {
      throw Exception(data.message);
    }
  }

  Future<bool> addBooking(
    int hotelId,
    int roomId,
    String checkin,
    String checkout,
    int rooms,
    int guests,
  ) async {
    final response = await _client.post(
      path:
          '${HotelsApi.base}/$hotelId${RoomsApi.base}/$roomId${BookingsApi.base}',
      data: {
        'booking_date': DateTime.now().toIso8601String(),
        'checkin': checkin,
        'checkout': checkout,
        'rooms': rooms,
        'guests': guests,
      },
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return data.status;
    } else {
      throw Exception(data.message);
    }
  }

  Future<bool> addReview(
    int hotelId,
    double rating,
    String review,
  ) async {
    final response = await _client.post(
      path: '${HotelsApi.base}/$hotelId${ReviewsApi.base}',
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
    final response = await _client.delete(
      path: '${HotelsApi.base}/$hotelId${ReviewsApi.base}/$reviewId',
    );
    final data = GeneralResponse.fromJson(response);

    if (data.status) {
      return data.status;
    } else {
      throw Exception(data.message);
    }
  }
}
