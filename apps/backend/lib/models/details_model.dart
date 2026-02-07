// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of 'models.dart';

class Details {
  static String table = Tables.details;
  int? id;
  List<String> amenities;
  List<String> rules;
  List<String> preferences;
  List<String> hotel_images;
  int? hotel_id;

  Details({
    required this.amenities,
    required this.rules,
    required this.preferences,
    required this.hotel_images,
    this.id,
    this.hotel_id,
  });

  Details copyWith({
    int? id,
    List<String>? amenities,
    List<String>? rules,
    List<String>? preferences,
    List<String>? hotel_images,
    int? hotel_id,
  }) {
    return Details(
      id: id ?? this.id,
      amenities: amenities ?? this.amenities,
      rules: rules ?? this.rules,
      preferences: preferences ?? this.preferences,
      hotel_images: hotel_images ?? this.hotel_images,
      hotel_id: hotel_id ?? this.hotel_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'amenities': amenities,
      'rules': rules,
      'preferences': preferences,
      'hotel_images': hotel_images,
      'hotel_id': hotel_id,
    };
  }

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'] != null ? json['id'] as int : null,
      amenities: List<String>.from(json['amenities'] as List<dynamic>),
      rules: List<String>.from(json['rules'] as List<dynamic>),
      preferences: List<String>.from(json['preferences'] as List<dynamic>),
      hotel_images: List<String>.from(json['hotel_images'] as List<dynamic>),
      hotel_id: json['hotel_id'] != null ? json['hotel_id'] as int : null,
    );
  }

  static Future<void> create(
    Connection connection,
    Details? data,
  ) async {
    var keys = '';
    var values = '';
    data?.toJson().keys.forEach((key) {
      if (key != 'id') {
        if (keys != '') {
          keys += ', ';
          values += ', ';
        }
        keys += key;
        values += '@$key';
      }
    });
    await connection.execute(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      parameters: data?.toJson(),
    );
  }

  static Future<Details> read(
    Connection connection,
    String id,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$id'",
    );
    final data = result
        .map((row) => Details.fromJson(row.toColumnMap()))
        .toList();
    return data.first;
  }

  static Future<void> update(
    Connection connection,
    Details? data,
    String id,
  ) async {
    var values = '';
    data?.toJson().forEach((key, value) {
      if (values != '') values += ', ';
      if (!key.contains('id')) {
        value = value.toString().replaceAll('[', '{');
        value = value.toString().replaceAll(']', '}');
      }
      values += "$key = '$value'";
    });

    await connection.execute(
      'UPDATE $table '
      'SET $values '
      "WHERE hotel_id = '$id'",
    );
  }

  static Future<void> delete(
    Connection connection,
    String id,
  ) async {
    await connection.execute(
      'DELETE FROM $table '
      "WHERE hotel_id = '$id'",
    );
  }
}
