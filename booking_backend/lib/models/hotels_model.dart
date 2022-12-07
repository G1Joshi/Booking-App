// ignore_for_file: sort_constructors_first, non_constant_identifier_names

import 'package:booking_backend/database/tables.dart';
import 'package:postgres/postgres.dart';

part 'address_model.dart';
part 'booking_model.dart';
part 'contact_model.dart';
part 'details_model.dart';
part 'hotel_model.dart';
part 'reviews_model.dart';
part 'room_model.dart';

class HotelModel {
  Hotel? hotel;
  Address? address;
  Contact? contact;
  Booking? booking;
  Details? details;
  List<Reviews>? reviews;
  List<Room>? rooms;

  HotelModel({
    this.hotel,
    this.address,
    this.contact,
    this.booking,
    this.details,
    this.reviews,
    this.rooms,
  });

  HotelModel copyWith({
    Hotel? hotel,
    Address? address,
    Contact? contact,
    Booking? booking,
    Details? details,
    List<Reviews>? reviews,
    List<Room>? rooms,
  }) {
    return HotelModel(
      hotel: hotel ?? this.hotel,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      booking: booking ?? this.booking,
      details: details ?? this.details,
      reviews: reviews ?? this.reviews,
      rooms: rooms ?? this.rooms,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'hotel': hotel?.toJson(),
      'address': address?.toJson(),
      'contact': contact?.toJson(),
      'booking': booking?.toJson(),
      'details': details?.toJson(),
      'reviews': reviews?.map((x) => x.toJson()).toList(),
      'rooms': rooms?.map((x) => x.toJson()).toList(),
    };
  }

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      hotel: json['hotel'] != null
          ? Hotel.fromJson(json['hotel'] as Map<String, dynamic>)
          : null,
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      contact: json['contact'] != null
          ? Contact.fromJson(json['contact'] as Map<String, dynamic>)
          : null,
      booking: json['booking'] != null
          ? Booking.fromJson(json['booking'] as Map<String, dynamic>)
          : null,
      details: json['details'] != null
          ? Details.fromJson(json['details'] as Map<String, dynamic>)
          : null,
      reviews: json['reviews'] != null
          ? List<Reviews>.from(
              (json['reviews'] as List<int>).map<Reviews?>(
                (x) => Reviews.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      rooms: json['rooms'] != null
          ? List<Room>.from(
              (json['rooms'] as List<int>).map<Room?>(
                (x) => Room.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
