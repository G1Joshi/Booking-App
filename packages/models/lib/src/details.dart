class Details {
  const Details({
    required this.id,
    required this.amenities,
    required this.rules,
    required this.preferences,
    required this.hotelImages,
    required this.hotelId,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'] as int,
      amenities: List<String>.from(json['amenities'] as List<dynamic>),
      rules: List<String>.from(json['rules'] as List<dynamic>),
      preferences: List<String>.from(json['preferences'] as List<dynamic>),
      hotelImages: List<String>.from(json['hotel_images'] as List<dynamic>),
      hotelId: json['hotel_id'] as int,
    );
  }

  final int id;

  final List<String> amenities;

  final List<String> rules;

  final List<String> preferences;

  final List<String> hotelImages;

  final int hotelId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'amenities': amenities,
    'rules': rules,
    'preferences': preferences,
    'hotel_images': hotelImages,
    'hotel_id': hotelId,
  };

  Details copyWith({
    int? id,
    List<String>? amenities,
    List<String>? rules,
    List<String>? preferences,
    List<String>? hotelImages,
    int? hotelId,
  }) {
    return Details(
      id: id ?? this.id,
      amenities: amenities ?? this.amenities,
      rules: rules ?? this.rules,
      preferences: preferences ?? this.preferences,
      hotelImages: hotelImages ?? this.hotelImages,
      hotelId: hotelId ?? this.hotelId,
    );
  }
}
