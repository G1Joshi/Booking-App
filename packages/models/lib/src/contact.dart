class Contact {
  const Contact({
    required this.id,
    required this.phone,
    required this.email,
    required this.website,
    required this.hotelId,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as int,
      phone: json['phone'] as int,
      email: json['email'] as String,
      website: json['website'] as String,
      hotelId: json['hotel_id'] as int,
    );
  }

  final int id;

  final int phone;

  final String email;

  final String website;

  final int hotelId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'phone': phone,
    'email': email,
    'website': website,
    'hotel_id': hotelId,
  };

  Contact copyWith({
    int? id,
    int? phone,
    String? email,
    String? website,
    int? hotelId,
  }) {
    return Contact(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      hotelId: hotelId ?? this.hotelId,
    );
  }
}
