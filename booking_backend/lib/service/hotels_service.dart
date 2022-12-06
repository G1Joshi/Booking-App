import 'package:booking_backend/database/tables.dart';
import 'package:booking_backend/models/hotels_model.dart';
import 'package:postgres/postgres.dart';

class HotelService {
  HotelService(this.connection);

  final PostgreSQLConnection connection;

  Future<HotelModel> create(HotelModel hotel) async {
    final result = await connection.query(
      "SELECT nextval('${Tables.hotels}_id_seq')",
    );
    final id = result.first.first as int;
    await Hotel.create(connection, hotel.hotel?.copyWith(id: id));
    await Address.create(connection, hotel.address?.copyWith(hotel_id: id));
    await Contact.create(connection, hotel.contact?.copyWith(hotel_id: id));
    await Booking.create(connection, hotel.booking?.copyWith(hotel_id: id));
    await Details.create(connection, hotel.details?.copyWith(hotel_id: id));
    return hotel;
  }

  Future<HotelModel?> read(String id) async {
    return HotelModel(
      hotel: await Hotel.read(connection, id),
      details: await Details.read(connection, id),
      address: await Address.read(connection, id),
      contact: await Contact.read(connection, id),
      booking: await Booking.read(connection, id),
    );
  }

  Future<List<Hotel>> readAll() async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM ${Tables.hotels}',
    );
    final data = result.map((e) => Hotel.fromJson(e[Tables.hotels]!)).toList();
    return data;
  }

  Future<HotelModel> update(int id, HotelModel hotel) async {
    await Hotel.update(connection, hotel.hotel, id.toString());
    await Address.update(connection, hotel.address, id.toString());
    await Contact.update(connection, hotel.contact, id.toString());
    await Booking.update(connection, hotel.booking, id.toString());
    await Details.update(connection, hotel.details, id.toString());
    return hotel;
  }

  Future<void> delete(String id) async {
    await Future.wait([
      Details.delete(connection, id),
      Booking.delete(connection, id),
      Contact.delete(connection, id),
      Address.delete(connection, id),
      Hotel.delete(connection, id),
    ]);
  }

  Future<List<Hotel>> search(String col, String? query) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM ${Tables.hotels} '
      "WHERE $col iLIKE '%$query%'",
    );
    final data = result.map((e) => Hotel.fromJson(e[Tables.hotels]!)).toList();
    return data;
  }
}
