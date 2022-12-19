class HotelDetails {
  HotelDetails({
    required this.hotel,
    required this.address,
    required this.contact,
    required this.details,
    required this.reviews,
    required this.rooms,
  });

  factory HotelDetails.fromJson(Map<String, dynamic> map) {
    return HotelDetails(
      hotel: Hotel.fromJson(map['hotel'] as Map<String, dynamic>),
      address: Address.fromJson(map['address'] as Map<String, dynamic>),
      contact: Contact.fromJson(map['contact'] as Map<String, dynamic>),
      details: Details.fromJson(map['details'] as Map<String, dynamic>),
      reviews: List<Review>.from(
        (map['reviews'] as List<dynamic>).map<Review>(
          (x) => Review.fromJson(x as Map<String, dynamic>),
        ),
      ),
      rooms: List<Room>.from(
        (map['rooms'] as List<dynamic>).map<Room>(
          (x) => Room.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Hotel hotel;
  Address address;
  Contact contact;
  Details details;
  List<Review> reviews;
  List<Room> rooms;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'hotel': hotel.toJson(),
      'address': address.toJson(),
      'contact': contact.toJson(),
      'details': details.toJson(),
      'reviews': reviews.map((x) => x.toJson()).toList(),
      'rooms': rooms.map((x) => x.toJson()).toList(),
    };
  }
}

class Hotel {
  Hotel({
    required this.id,
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
      id: json['id'] as int,
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

  int id;
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

class Address {
  Address({
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
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      hotelId: json['hotel_id'] as int,
    );
  }

  int id;
  String street;
  String city;
  String state;
  String country;
  int pincode;
  double latitude;
  double longitude;
  int hotelId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
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
  }
}

class Contact {
  Contact({
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

  int id;
  int phone;
  String email;
  String website;
  int hotelId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'phone': phone,
      'email': email,
      'website': website,
      'hotel_id': hotelId,
    };
  }
}

class Details {
  Details({
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

  int id;
  List<String> amenities;
  List<String> rules;
  List<String> preferences;
  List<String> hotelImages;
  int hotelId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'amenities': amenities,
      'rules': rules,
      'preferences': preferences,
      'hotel_images': hotelImages,
      'hotel_id': hotelId,
    };
  }
}

class Review {
  Review({
    required this.id,
    required this.name,
    required this.rating,
    required this.review,
    required this.guestImages,
    required this.hotelId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      name: json['name'] as String,
      rating: json['rating'] as num,
      review: json['review'] as String,
      guestImages: List<String>.from(json['guest_images'] as List<dynamic>),
      hotelId: json['hotel_id'] as int,
    );
  }

  int id;
  String name;
  num rating;
  String review;
  List<String> guestImages;
  int hotelId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'rating': rating,
      'review': review,
      'guest_images': guestImages,
      'hotel_id': hotelId,
    };
  }
}

class Room {
  Room({
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

  int id;
  String category;
  String description;
  int price;
  int count;
  int capacity;
  List<String> amenities;
  List<String> roomImages;
  int hotelId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
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
  }
}
