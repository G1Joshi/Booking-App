// ignore_for_file: non_constant_identifier_names, sort_constructors_first

import 'package:booking_backend/database/tables.dart';
import 'package:postgres/postgres.dart';

class User {
  static String table = Tables.users;
  String id;
  String name;
  String email;
  String profile_image;
  int phone;
  String date_of_birth;
  String city;
  String state;
  String country;
  int pincode;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profile_image,
    required this.phone,
    required this.date_of_birth,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profile_image,
    int? phone,
    String? date_of_birth,
    String? city,
    String? state,
    String? country,
    int? pincode,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profile_image: profile_image ?? this.profile_image,
      phone: phone ?? this.phone,
      date_of_birth: date_of_birth ?? this.date_of_birth,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profile_image': profile_image,
      'phone': phone,
      'date_of_birth': date_of_birth,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profile_image: json['profile_image'] as String,
      phone: json['phone'] as int,
      date_of_birth: json['date_of_birth'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as int,
    );
  }

  static Future<bool> checkAccount(
    PostgreSQLConnection connection,
    String id,
  ) async {
    final result = await connection.query(
      'SELECT COUNT(*) '
      'FROM $table '
      "WHERE id = '$id'",
    );
    return result.first.first != 0;
  }

  static Future<void> create(
    PostgreSQLConnection connection,
    User? data,
  ) async {
    var keys = '';
    var values = '';
    data?.toJson().keys.forEach((key) {
      if (keys != '') {
        keys += ', ';
        values += ', ';
      }
      keys += key;
      values += '@$key';
    });
    await connection.query(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      substitutionValues: data?.toJson(),
    );
  }
}
