class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] != null
          ? json['profile_image'] as String
          : null,
      phone: json['phone'] as int,
      dateOfBirth: json['date_of_birth'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as int,
    );
  }

  String id;
  String name;
  String email;
  String? profileImage;
  int phone;
  String dateOfBirth;
  String city;
  String state;
  String country;
  int pincode;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profile_image': profileImage,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
    };
  }
}
