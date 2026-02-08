import 'package:booking_backend/database/extensions.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class HotelService {
  HotelService(this.connection);

  final Connection connection;

  Future<void> create(Hotel hotel, [int? i]) async {
    final id = i ?? await HotelDb.getId(connection);
    await HotelDb.create(connection, hotel.copyWith(id: id));
    await AddressDb.create(connection, hotel.address?.copyWith(hotelId: id));
    await ContactDb.create(connection, hotel.contact?.copyWith(hotelId: id));
    await DetailsDb.create(connection, hotel.details?.copyWith(hotelId: id));
  }

  Future<Hotel?> read(String id) async {
    final hotel = await HotelDb.read(connection, id);
    return Hotel(
      id: hotel.id,
      name: hotel.name,
      description: hotel.description,
      propertyType: hotel.propertyType,
      chain: hotel.chain,
      star: hotel.star,
      rating: hotel.rating,
      roomsStartingPrice: hotel.roomsStartingPrice,
      coverImage: hotel.coverImage,
      details: await DetailsDb.read(connection, id),
      address: await AddressDb.read(connection, id),
      contact: await ContactDb.read(connection, id),
      reviews: await ReviewDb.readAll(connection, id),
      rooms: await RoomDb.readAll(connection, id),
    );
  }

  Future<List<Hotel>> readAll() async {
    final hotels = await HotelDb.readAll(connection);
    return hotels;
  }

  Future<void> update(int id, Hotel hotel) async {
    await HotelDb.update(connection, hotel, id.toString());
    await AddressDb.update(connection, hotel.address, id.toString());
    await ContactDb.update(connection, hotel.contact, id.toString());
    await DetailsDb.update(connection, hotel.details, id.toString());
  }

  Future<void> delete(String id) async {
    await Future.wait([
      ReviewDb.deleteAll(connection, id),
      DetailsDb.delete(connection, id),
      ContactDb.delete(connection, id),
      AddressDb.delete(connection, id),
      RoomDb.deleteAll(connection, id),
      HotelDb.delete(connection, id),
    ]);
  }

  Future<List<Hotel>> search(
    String locality,
    int distance,
    String checkin,
    String checkout,
    int rooms,
  ) async {
    final hotels = await HotelDb.search(
      connection,
      locality,
      distance,
      checkin,
      checkout,
      rooms,
    );
    return hotels;
  }

  Future<List<Hotel>> filter(
    String? star,
    String? rating,
    String? propertyType,
    String? budget,
  ) async {
    final hotels = await HotelDb.filter(
      connection,
      star,
      rating,
      propertyType,
      budget,
    );
    return hotels;
  }
}
