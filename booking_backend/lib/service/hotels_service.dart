import 'package:booking_backend/models/hotels_model.dart';
import 'package:postgres/postgres.dart';

class HotelService {
  HotelService(this.connection);

  final PostgreSQLConnection connection;

  Future<HotelsModel> create(HotelsModel hotel, [int? i]) async {
    final id = i ?? await Hotel.getId(connection);
    await Hotel.create(connection, hotel.hotel?.copyWith(id: id));
    await Address.create(connection, hotel.address?.copyWith(hotel_id: id));
    await Contact.create(connection, hotel.contact?.copyWith(hotel_id: id));
    await Details.create(connection, hotel.details?.copyWith(hotel_id: id));
    return hotel;
  }

  Future<HotelsModel?> read(String id) async {
    return HotelsModel(
      hotel: await Hotel.read(connection, id),
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

  Future<HotelsModel> update(int id, HotelsModel hotel) async {
    await Hotel.update(connection, hotel.hotel, id.toString());
    await Address.update(connection, hotel.address, id.toString());
    await Contact.update(connection, hotel.contact, id.toString());
    await Details.update(connection, hotel.details, id.toString());
    return hotel;
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
}
