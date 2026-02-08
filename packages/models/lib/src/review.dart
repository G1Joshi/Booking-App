class Review {
  const Review({
    required this.rating,
    required this.review,
    this.id,
    this.name,
    this.profileImage,
    this.guestImages,
    this.hotelId,
    this.userId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] as String?,
      profileImage: json['profile_image'] as String?,
      rating: json['rating'] as num,
      review: json['review'] as String,
      guestImages: json['guest_images'] != null
          ? List<String>.from(json['guest_images'] as List<dynamic>)
          : null,
      hotelId: json['hotel_id'] != null ? json['hotel_id'] as int : null,
      userId: json['user_id'] as String?,
    );
  }

  final int? id;

  final String? name;

  final String? profileImage;

  final num rating;

  final String review;

  final List<String>? guestImages;

  final int? hotelId;

  final String? userId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'profile_image': profileImage,
    'rating': rating,
    'review': review,
    'guest_images': guestImages,
    'hotel_id': hotelId,
    'user_id': userId,
  };

  Review copyWith({
    int? id,
    String? name,
    String? profileImage,
    num? rating,
    String? review,
    List<String>? guestImages,
    int? hotelId,
    String? userId,
  }) {
    return Review(
      id: id ?? this.id,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      guestImages: guestImages ?? this.guestImages,
      hotelId: hotelId ?? this.hotelId,
      userId: userId ?? this.userId,
    );
  }
}
