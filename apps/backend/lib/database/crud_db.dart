import 'package:booking_backend/database/query_helper.dart';
import 'package:postgres/postgres.dart';

class CrudDb<T> {
  const CrudDb({
    required this.table,
    required this.fromJson,
    required this.toJson,
    this.primaryKey = 'hotel_id',
    this.excludeOnCreate = const ['id'],
  });

  final String table;
  final String primaryKey;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final List<String> excludeOnCreate;

  Future<Result> create(Connection connection, T? data) async {
    if (data == null) {
      return Result(rows: [], affectedRows: 0, schema: ResultSchema([]));
    }
    return QueryHelper.create(
      connection,
      table,
      toJson(data),
      exclude: excludeOnCreate,
    );
  }

  Future<T> read(Connection connection, String id) async {
    final result = await QueryHelper.read(
      connection,
      'SELECT * FROM $table WHERE $primaryKey = @id',
      {'id': id},
    );
    return result.map((row) => fromJson(row.toColumnMap())).toList().first;
  }

  Future<List<T>> readAll(Connection connection, [String? id]) async {
    if (id != null) {
      final result = await QueryHelper.read(
        connection,
        'SELECT * FROM $table WHERE $primaryKey = @id',
        {'id': id},
      );
      return result.map((row) => fromJson(row.toColumnMap())).toList();
    }
    final result = await QueryHelper.read(
      connection,
      'SELECT * FROM $table ORDER BY id',
    );
    return result.map((row) => fromJson(row.toColumnMap())).toList();
  }

  Future<void> update(Connection connection, T? data, String id) async {
    if (data == null) return;
    await QueryHelper.update(
      connection,
      table,
      toJson(data),
      where: '$primaryKey = @id',
      whereParams: {'id': id},
    );
  }

  Future<void> delete(Connection connection, String id) async {
    await QueryHelper.delete(
      connection,
      table,
      where: '$primaryKey = @id',
      whereParams: {'id': id},
    );
  }

  Future<T> readBy(
    Connection connection,
    Map<String, dynamic> where,
  ) async {
    final clause = where.keys.map((k) => '$k = @$k').join(' AND ');
    final result = await QueryHelper.read(
      connection,
      'SELECT * FROM $table WHERE $clause',
      where,
    );
    return result.map((row) => fromJson(row.toColumnMap())).toList().first;
  }

  Future<void> updateBy(
    Connection connection,
    T? data,
    Map<String, dynamic> where,
  ) async {
    if (data == null) return;
    final clause = where.keys.map((k) => '$k = @$k').join(' AND ');
    await QueryHelper.update(
      connection,
      table,
      toJson(data),
      where: clause,
      whereParams: where,
    );
  }

  Future<void> deleteBy(
    Connection connection,
    Map<String, dynamic> where,
  ) async {
    final clause = where.keys.map((k) => '$k = @$k').join(' AND ');
    await QueryHelper.delete(
      connection,
      table,
      where: clause,
      whereParams: where,
    );
  }

  Future<List<T>> query(
    Connection connection,
    String sql, [
    Map<String, dynamic> params = const {},
  ]) async {
    final result = await QueryHelper.read(connection, sql, params);
    return result.map((row) => fromJson(row.toColumnMap())).toList();
  }
}
