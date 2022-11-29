class Hotel {
  Hotel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.pincode,
    required this.city,
    required this.country,
    required this.rooms,
    required this.rating,
  }) : assert(id == null || id.isNotEmpty, 'ID cannot be blank');

  factory Hotel.fromJson(Map<String, dynamic> map) {
    return Hotel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      phone: map['phone'] as int,
      email: map['email'] as String,
      address: map['address'] as String,
      pincode: map['pincode'] as int,
      city: map['city'] as String,
      country: map['country'] as String,
      rooms: map['rooms'] as int,
      rating: map['rating'] as int,
    );
  }

  final String? id;
  final String name;
  final int phone;
  final String email;
  final String address;
  final int pincode;
  final String city;
  final String country;
  final int rooms;
  final int rating;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'pincode': pincode,
      'city': city,
      'country': country,
      'rooms': rooms,
      'rating': rating,
    };
  }

  Hotel copyWith({
    String? id,
    String? name,
    int? phone,
    String? email,
    String? address,
    int? pincode,
    String? city,
    String? country,
    int? rooms,
    int? rating,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      pincode: pincode ?? this.pincode,
      city: city ?? this.city,
      country: country ?? this.country,
      rooms: rooms ?? this.rooms,
      rating: rating ?? this.rating,
    );
  }
}
