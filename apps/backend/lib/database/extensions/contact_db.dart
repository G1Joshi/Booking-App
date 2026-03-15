import 'package:booking_backend/database/query_helper.dart';
import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class ContactDb {
  static final _crud = CrudDb<Contact>(
    table: Tables.contact,
    fromJson: Contact.fromJson,
    toJson: _toJson,
  );

  static Map<String, dynamic> _toJson(Contact data) => data.toJson();

  static Future<void> create(Connection connection, Contact? data) =>
      _crud.create(connection, data);

  static Future<Contact> read(Connection connection, String id) =>
      _crud.read(connection, id);

  static Future<void> update(
    Connection connection,
    Contact? data,
    String id,
  ) => _crud.update(connection, data, id);

  static Future<void> delete(Connection connection, String id) =>
      _crud.delete(connection, id);
}
