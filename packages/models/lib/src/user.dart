class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.dateOfBirth,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    this.accessToken,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as int,
      password: json['password'] != null ? json['password'] as String : '',
      accessToken: json['access_token'] != null
          ? json['access_token'] as String
          : null,
      profileImage: json['profile_image'] != null
          ? json['profile_image'] as String
          : null,
      dateOfBirth: json['date_of_birth'].toString(),
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as int,
    );
  }

  final String id;

  final String name;

  final String email;

  final int phone;

  final String password;

  final String? accessToken;

  final String? profileImage;

  final String dateOfBirth;

  final String city;

  final String state;

  final String country;

  final int pincode;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
    'access_token': accessToken,
    'profile_image': profileImage,
    'date_of_birth': dateOfBirth,
    'city': city,
    'state': state,
    'country': country,
    'pincode': pincode,
  };

  User copyWith({
    String? id,
    String? name,
    String? email,
    int? phone,
    String? password,
    String? accessToken,
    String? profileImage,
    String? dateOfBirth,
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
      accessToken: accessToken ?? this.accessToken,
      profileImage: profileImage ?? this.profileImage,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
    );
  }
}
