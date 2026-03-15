part of 'hotel_bloc.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class GetAllHotels extends HotelEvent {
  const GetAllHotels();
}

class SearchHotel extends HotelEvent {
  const SearchHotel({
    required this.city,
    required this.distance,
    required this.checkin,
    required this.checkout,
    required this.rooms,
  });

  final String city;
  final int distance;
  final String checkin;
  final String checkout;
  final int rooms;

  @override
  List<Object> get props => [city, distance, checkin, checkout, rooms];
}

class FilterHotel extends HotelEvent {
  const FilterHotel();
}

class GetHotelDetails extends HotelEvent {
  const GetHotelDetails(this.id);

  final int id;
}

class AddBooking extends HotelEvent {
  const AddBooking({
    required this.hotelId,
    required this.roomId,
    required this.checkin,
    required this.checkout,
    required this.roomCount,
    required this.guestCount,
  });

  final int hotelId;
  final int roomId;
  final String checkin;
  final String checkout;
  final int roomCount;
  final int guestCount;

  @override
  List<Object> get props => [
    hotelId,
    roomId,
    checkin,
    checkout,
    roomCount,
    guestCount,
  ];
}

class AddReview extends HotelEvent {
  const AddReview({
    required this.hotelId,
    required this.rating,
    required this.review,
  });

  final int hotelId;
  final double rating;
  final String review;

  @override
  List<Object> get props => [hotelId, rating, review];
}

class DeleteReview extends HotelEvent {
  const DeleteReview(this.hotelId, this.reviewId);

  final int hotelId;
  final int reviewId;
}
