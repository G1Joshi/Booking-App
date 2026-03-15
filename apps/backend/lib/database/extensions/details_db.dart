import 'package:booking_backend/database/query_helper.dart';
import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class DetailsDb {
  static final _crud = CrudDb<Details>(
    table: Tables.details,
    fromJson: Details.fromJson,
    toJson: _toJson,
  );

  static Map<String, dynamic> _toJson(Details data) => data.toJson();

  static Future<void> create(Connection connection, Details? data) =>
      _crud.create(connection, data);

  static Future<Details> read(Connection connection, String id) =>
      _crud.read(connection, id);

  static Future<void> update(
    Connection connection,
    Details? data,
    String id,
  ) => _crud.update(connection, data, id);

  static Future<void> delete(Connection connection, String id) =>
      _crud.delete(connection, id);
}
