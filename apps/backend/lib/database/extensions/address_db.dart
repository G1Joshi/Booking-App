import 'package:booking_backend/database/query_helper.dart';
import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class AddressDb {
  static final _crud = CrudDb<Address>(
    table: Tables.address,
    fromJson: Address.fromJson,
    toJson: _toJson,
  );

  static Map<String, dynamic> _toJson(Address data) => data.toJson();

  static Future<void> create(Connection connection, Address? data) =>
      _crud.create(connection, data);

  static Future<Address> read(Connection connection, String id) =>
      _crud.read(connection, id);

  static Future<void> update(
    Connection connection,
    Address? data,
    String id,
  ) => _crud.update(connection, data, id);

  static Future<void> delete(Connection connection, String id) =>
      _crud.delete(connection, id);
}
