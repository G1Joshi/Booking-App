// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of 'models.dart';

class Contact {
  static String table = Tables.contact;
  int? id;
  int phone;
  String email;
  String website;
  int? hotel_id;

  Contact({
    this.id,
    required this.phone,
    required this.email,
    required this.website,
    this.hotel_id,
  });

  Contact copyWith({
    int? id,
    int? phone,
    String? email,
    String? website,
    int? hotel_id,
  }) {
    return Contact(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      hotel_id: hotel_id ?? this.hotel_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'phone': phone,
      'email': email,
      'website': website,
      'hotel_id': hotel_id,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] != null ? json['id'] as int : null,
      phone: json['phone'] as int,
      email: json['email'] as String,
      website: json['website'] as String,
      hotel_id: json['hotel_id'] != null ? json['hotel_id'] as int : null,
    );
  }

  static Future<void> create(
    PostgreSQLConnection connection,
    Contact? data,
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
    await connection.query(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      substitutionValues: data?.toJson(),
    );
  }

  static Future<Contact> read(
    PostgreSQLConnection connection,
    String id,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$id'",
    );
    final data = result.map((e) => Contact.fromJson(e[table]!)).toList();
    return data.first;
  }

  static Future<void> update(
    PostgreSQLConnection connection,
    Contact? data,
    String id,
  ) async {
    var values = '';
    data?.toJson().forEach((key, value) {
      if (values != '') values += ', ';
      values += "$key = '$value'";
    });

    await connection.query(
      'UPDATE $table '
      'SET $values '
      "WHERE hotel_id = '$id'",
    );
  }

  static Future<void> delete(
    PostgreSQLConnection connection,
    String id,
  ) async {
    await connection.query(
      'DELETE FROM $table '
      "WHERE hotel_id = '$id'",
    );
  }
}
