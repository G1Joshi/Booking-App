class Address {
  const Address({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.latitude,
    required this.longitude,
    required this.hotelId,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      hotelId: json['hotel_id'] as int,
    );
  }

  final int id;

  final String street;

  final String city;

  final String state;

  final String country;

  final int pincode;

  final double latitude;

  final double longitude;

  final int hotelId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'street': street,
    'city': city,
    'state': state,
    'country': country,
    'pincode': pincode,
    'latitude': latitude,
    'longitude': longitude,
    'hotel_id': hotelId,
  };

  Address copyWith({
    int? id,
    String? street,
    String? city,
    String? state,
    String? country,
    int? pincode,
    double? latitude,
    double? longitude,
    int? hotelId,
  }) {
    return Address(
      id: id ?? this.id,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      hotelId: hotelId ?? this.hotelId,
    );
  }
}
