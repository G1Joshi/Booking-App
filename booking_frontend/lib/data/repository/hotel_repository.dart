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

  Future<List<Hotel>> search(
    String locality,
    String checkin,
    String checkout,
    int rooms,
  ) async {
    final queryParameters = {
      'locality': locality,
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
}
