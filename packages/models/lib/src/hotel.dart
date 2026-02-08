import 'address.dart';
import 'contact.dart';
import 'details.dart';
import 'review.dart';
import 'room.dart';

class Hotel {
  const Hotel({
    required this.name,
    required this.description,
    required this.propertyType,
    required this.chain,
    required this.star,
    required this.rating,
    required this.roomsStartingPrice,
    required this.coverImage,
    this.id,
    this.address,
    this.contact,
    this.details,
    this.reviews,
    this.rooms,
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
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      contact: json['contact'] != null
          ? Contact.fromJson(json['contact'] as Map<String, dynamic>)
          : null,
      details: json['details'] != null
          ? Details.fromJson(json['details'] as Map<String, dynamic>)
          : null,
      reviews: json['reviews'] != null
          ? List<Review>.from(
              (json['reviews'] as List<dynamic>).map(
                (x) => Review.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      rooms: json['rooms'] != null
          ? List<Room>.from(
              (json['rooms'] as List<dynamic>).map(
                (x) => Room.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  final int? id;

  final String name;

  final String description;

  final String propertyType;

  final String chain;

  final int star;

  final num rating;

  final int roomsStartingPrice;

  final String coverImage;

  final Address? address;

  final Contact? contact;

  final Details? details;

  final List<Review>? reviews;

  final List<Room>? rooms;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'property_type': propertyType,
    'chain': chain,
    'star': star,
    'rating': rating,
    'rooms_starting_price': roomsStartingPrice,
    'cover_image': coverImage,
    'address': address?.toJson(),
    'contact': contact?.toJson(),
    'details': details?.toJson(),
    'reviews': reviews?.map((x) => x.toJson()).toList(),
    'rooms': rooms?.map((x) => x.toJson()).toList(),
  };

  Hotel copyWith({
    int? id,
    String? name,
    String? description,
    String? propertyType,
    String? chain,
    int? star,
    num? rating,
    int? roomsStartingPrice,
    String? coverImage,
    Address? address,
    Contact? contact,
    Details? details,
    List<Review>? reviews,
    List<Room>? rooms,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      propertyType: propertyType ?? this.propertyType,
      chain: chain ?? this.chain,
      star: star ?? this.star,
      rating: rating ?? this.rating,
      roomsStartingPrice: roomsStartingPrice ?? this.roomsStartingPrice,
      coverImage: coverImage ?? this.coverImage,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      details: details ?? this.details,
      reviews: reviews ?? this.reviews,
      rooms: rooms ?? this.rooms,
    );
  }
}
