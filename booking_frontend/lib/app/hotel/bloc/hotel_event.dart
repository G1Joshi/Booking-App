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
    required this.checkin,
    required this.checkout,
    required this.rooms,
  });

  final String city;
  final String checkin;
  final String checkout;
  final int rooms;
}
