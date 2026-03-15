import 'package:postgres/postgres.dart';
export 'crud_db.dart';

class QueryHelper {
  static Future<Result> create(
    Connection connection,
    String table,
    Map<String, dynamic> data, {
    List<String> exclude = const ['id'],
  }) async {
    final keysList = <String>[];
    final valuesList = <String>[];
    final params = <String, dynamic>{};

    for (final entry in data.entries) {
      if (exclude.contains(entry.key)) continue;
      keysList.add(entry.key);
      valuesList.add('@${entry.key}');
      params[entry.key] = entry.value;
    }

    final keys = keysList.join(', ');
    final values = valuesList.join(', ');

    return connection.execute(
      Sql.named('INSERT INTO $table ($keys) VALUES ($values)'),
      parameters: params,
    );
  }

  static Future<Result> read(
    Connection connection,
    String query, [
    Map<String, dynamic> params = const {},
  ]) async {
    return connection.execute(
      Sql.named(query),
      parameters: params,
    );
  }

  static Future<void> update(
    Connection connection,
    String table,
    Map<String, dynamic> data, {
    required String where,
    required Map<String, dynamic> whereParams,
  }) async {
    final setClauses = <String>[];
    final params = <String, dynamic>{};

    for (final entry in data.entries) {
      setClauses.add('${entry.key} = @${entry.key}');
      params[entry.key] = entry.value;
    }
    params.addAll(whereParams);

    await connection.execute(
      Sql.named('UPDATE $table SET ${setClauses.join(', ')} WHERE $where'),
      parameters: params,
    );
  }

  static Future<void> delete(
    Connection connection,
    String table, {
    required String where,
    required Map<String, dynamic> whereParams,
  }) async {
    await connection.execute(
      Sql.named('DELETE FROM $table WHERE $where'),
      parameters: whereParams,
    );
  }
}
