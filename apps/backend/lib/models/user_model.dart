// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of 'models.dart';

class User {
  static String table = Tables.users;
  String id;
  String name;
  String email;
  int phone;
  String password;
  String? access_token;
  String? profile_image;
  String date_of_birth;
  String city;
  String state;
  String country;
  int pincode;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.date_of_birth,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    this.access_token,
    this.profile_image,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    int? phone,
    String? password,
    String? access_token,
    String? profile_image,
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
      phone: phone ?? this.phone,
      password: password ?? this.password,
      access_token: access_token ?? this.access_token,
      profile_image: profile_image ?? this.profile_image,
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
      'phone': phone,
      'password': password,
      'access_token': access_token,
      'profile_image': profile_image,
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
      phone: json['phone'] as int,
      password: json['password'] != null ? json['password'] as String : '',
      access_token: json['access_token'] != null
          ? json['access_token'] as String
          : null,
      profile_image: json['profile_image'] != null
          ? json['profile_image'] as String
          : null,
      date_of_birth: json['date_of_birth'].toString(),
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as int,
    );
  }

  static Future<String?> checkAccount(
    Connection connection,
    String email,
    String password,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE email = '$email' AND password = '$password'",
    );
    final data = result.map((row) => User.fromJson(row.toColumnMap())).toList();
    if (data.isNotEmpty) {
      return data.first.access_token;
    }
    return null;
  }

  static Future<bool> create(
    Connection connection,
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
    final result = await connection.execute(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      parameters: data?.toJson(),
    );
    return result.affectedRows > 0;
  }

  static Future<User> read(
    Connection connection,
    String id,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE id = '$id'",
    );
    final data = result.map((row) => User.fromJson(row.toColumnMap())).toList();
    return data.first;
  }

  static Future<String> getUserId(
    Connection connection,
    String accessToken,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE access_token = '$accessToken'",
    );
    final data = result.map((row) => User.fromJson(row.toColumnMap())).toList();
    if (data.isNotEmpty) {
      return data.first.id;
    }
    return '';
  }
}
