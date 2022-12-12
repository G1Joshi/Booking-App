class Hotel {
  Hotel({
    this.id,
    required this.name,
    required this.description,
    required this.propertyType,
    required this.chain,
    required this.star,
    required this.rating,
    required this.roomsStartingPrice,
    required this.coverImage,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] as String,
      description: json['description'] as String,
      propertyType: json['property_type'] as String,
      chain: json['chain'] as String,
      star: json['star'] as int,
      rating: json['rating'] as num,
      roomsStartingPrice: json['rooms_starting_price'] as int,
      coverImage: json['cover_image'] as String,
    );
  }

  int? id;
  String name;
  String description;
  String propertyType;
  String chain;
  int star;
  num rating;
  int roomsStartingPrice;
  String coverImage;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'property_type': propertyType,
      'chain': chain,
      'star': star,
      'rating': rating,
      'rooms_starting_price': roomsStartingPrice,
      'cover_image': coverImage,
    };
  }
}
