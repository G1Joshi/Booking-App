class Room {
  const Room({
    required this.id,
    required this.category,
    required this.description,
    required this.price,
    required this.count,
    required this.capacity,
    required this.amenities,
    required this.roomImages,
    required this.hotelId,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as int,
      category: json['category'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      count: json['count'] as int,
      capacity: json['capacity'] as int,
      amenities: List<String>.from(json['amenities'] as List<dynamic>),
      roomImages: List<String>.from(json['room_images'] as List<dynamic>),
      hotelId: json['hotel_id'] as int,
    );
  }

  final int id;

  final String category;

  final String description;

  final int price;

  final int count;

  final int capacity;

  final List<String> amenities;

  final List<String> roomImages;

  final int hotelId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'description': description,
    'price': price,
    'count': count,
    'capacity': capacity,
    'amenities': amenities,
    'room_images': roomImages,
    'hotel_id': hotelId,
  };

  Room copyWith({
    int? id,
    String? category,
    String? description,
    int? price,
    int? count,
    int? capacity,
    List<String>? amenities,
    List<String>? roomImages,
    int? hotelId,
  }) {
    return Room(
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      count: count ?? this.count,
      capacity: capacity ?? this.capacity,
      amenities: amenities ?? this.amenities,
      roomImages: roomImages ?? this.roomImages,
      hotelId: hotelId ?? this.hotelId,
    );
  }
}
