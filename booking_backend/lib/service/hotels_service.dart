import 'package:booking_backend/models/models.dart';
import 'package:postgres/postgres.dart';

class HotelService {
  HotelService(this.connection);

  final PostgreSQLConnection connection;

  Future<void> create(Hotel hotel, [int? i]) async {
    final id = i ?? await Hotel.getId(connection);
    await Hotel.create(connection, hotel.copyWith(id: id));
    await Address.create(connection, hotel.address?.copyWith(hotel_id: id));
    await Contact.create(connection, hotel.contact?.copyWith(hotel_id: id));
    await Details.create(connection, hotel.details?.copyWith(hotel_id: id));
  }

  Future<Hotel?> read(String id) async {
    final hotel = await Hotel.read(connection, id);
    return Hotel(
      id: hotel.id,
      name: hotel.name,
      description: hotel.description,
      property_type: hotel.property_type,
      chain: hotel.chain,
      star: hotel.star,
      rating: hotel.rating,
      rooms_starting_price: hotel.rooms_starting_price,
      cover_image: hotel.cover_image,
      details: await Details.read(connection, id),
      address: await Address.read(connection, id),
      contact: await Contact.read(connection, id),
      reviews: await Review.readAll(connection, id),
      rooms: await Room.readAll(connection, id),
    );
  }

  Future<List<Hotel>> readAll() async {
    final hotels = await Hotel.readAll(connection);
    return hotels;
  }

  Future<void> update(int id, Hotel hotel) async {
    await Hotel.update(connection, hotel, id.toString());
    await Address.update(connection, hotel.address, id.toString());
    await Contact.update(connection, hotel.contact, id.toString());
    await Details.update(connection, hotel.details, id.toString());
  }

  Future<void> delete(String id) async {
    await Future.wait([
      Review.deleteAll(connection, id),
      Details.delete(connection, id),
      Contact.delete(connection, id),
      Address.delete(connection, id),
      Room.deleteAll(connection, id),
      Hotel.delete(connection, id),
    ]);
  }

  Future<List<Hotel>> search(
    String locality,
    int distance,
    String checkin,
    String checkout,
    int rooms,
  ) async {
    final hotels = await Hotel.search(
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
    final hotels = await Hotel.filter(
      connection,
      star,
      rating,
      propertyType,
      budget,
    );
    return hotels;
  }
}
