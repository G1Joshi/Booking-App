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
  const SearchHotel();
}

class FilterHotel extends HotelEvent {
  const FilterHotel();
}

class GetHotelDetails extends HotelEvent {
  const GetHotelDetails(this.id);

  final int id;
}
