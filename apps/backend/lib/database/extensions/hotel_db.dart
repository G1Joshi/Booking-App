import 'package:booking_backend/database/query_helper.dart';
import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class HotelDb {
  static final _crud = CrudDb<Hotel>(
    table: Tables.hotels,
    fromJson: _fromDatabase,
    toJson: _toDatabase,
    primaryKey: 'id',
    excludeOnCreate: [],
  );

  static Future<int> getId(Connection connection) async {
    final result = await QueryHelper.read(
      connection,
      "SELECT nextval('${Tables.hotels}_id_seq')",
    );
    return result.first.first as int? ?? 0;
  }

  static Future<void> create(Connection connection, Hotel? data) =>
      _crud.create(connection, data);

  static Future<Hotel> read(Connection connection, String id) =>
      _crud.read(connection, id);

  static Future<List<Hotel>> readAll(Connection connection) =>
      _crud.readAll(connection);

  static Future<void> update(
    Connection connection,
    Hotel? data,
    String id,
  ) => _crud.update(connection, data, id);

  static Future<void> delete(Connection connection, String id) =>
      _crud.delete(connection, id);

  static Future<List<Hotel>> search(
    Connection connection,
    String locality,
    int distance,
    String checkin,
    String checkout,
    int rooms,
  ) => _crud.query(
    connection,
    'SELECT * FROM ${Tables.hotels} '
    'WHERE id IN ( '
    '  SELECT hotel_id FROM ( '
    '    SELECT r.id, r.hotel_id, '
    '      CASE WHEN ( '
    '        b.checkin BETWEEN @checkin AND @checkout '
    '        OR b.checkout BETWEEN @checkin AND @checkout '
    '        OR @checkin BETWEEN b.checkin AND b.checkout '
    '        OR @checkout BETWEEN b.checkin AND b.checkout '
    '      ) '
    '      THEN r.count - COALESCE(SUM(b.rooms), 0) '
    '      ELSE r.count '
    '    END AS available_rooms '
    '    FROM ${Tables.rooms} r '
    '    LEFT JOIN ${Tables.bookings} b ON r.id = b.room_id '
    '    GROUP BY r.id, b.checkin, b.checkout '
    '  ) AS subquery '
    '  WHERE available_rooms >= @rooms '
    '  INTERSECT '
    '  SELECT h.hotel_id FROM ${Tables.address} h '
    '  JOIN ${Tables.localities} l '
    '    ON distance(h.latitude, h.longitude, l.latitude, l.longitude) < @distance '
    '  WHERE l.name ILIKE @locality '
    ')',
    {
      'checkin': checkin,
      'checkout': checkout,
      'rooms': rooms,
      'distance': distance,
      'locality': '%$locality%',
    },
  );

  static Future<List<Hotel>> filter(
    Connection connection,
    String? star,
    String? rating,
    String? propertyType,
    String? budget,
  ) {
    var query = 'SELECT * FROM ${Tables.hotels} WHERE 1=1 ';
    final params = <String, dynamic>{};

    if (star != null) {
      params['star'] = star.split(',').map(int.parse).toList();
      query += 'AND star >= ANY (@star) ';
    }
    if (rating != null) {
      params['rating'] = rating.split(',').map(num.parse).toList();
      query += 'AND rating >= ANY (@rating) ';
    }
    if (propertyType != null) {
      params['propertyType'] = propertyType.split(',');
      query += 'AND property_type = ANY (@propertyType) ';
    }
    if (budget != null) {
      params['budget'] = budget.split(',').map(int.parse).toList();
      query += 'AND rooms_starting_price <= ANY (@budget) ';
    }

    return _crud.query(connection, query, params);
  }

  static Map<String, dynamic> _toDatabase(Hotel data) {
    return <String, dynamic>{
      'id': data.id,
      'name': data.name,
      'description': data.description,
      'property_type': data.propertyType,
      'chain': data.chain,
      'star': data.star,
      'rating': data.rating,
      'rooms_starting_price': data.roomsStartingPrice,
      'cover_image': data.coverImage,
    };
  }

  static Hotel _fromDatabase(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] as String,
      description: json['description'] as String,
      propertyType: json['property_type'] as String,
      chain: json['chain'] as String,
      star: json['star'] as int,
      rating: json['rating'] as num,
      roomsStartingPrice: json['rooms_starting_price'] as int,
      coverImage: json['cover_image'] as String,
    );
  }
}
