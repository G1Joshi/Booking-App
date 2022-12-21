part of 'hotel_bloc.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

class HotelInitial extends HotelState {
  const HotelInitial();
}

class HotelsLoading extends HotelState {
  const HotelsLoading();
}

class HotelsSearching extends HotelState {
  const HotelsSearching();
}

class HotelsLoaded extends HotelState {
  const HotelsLoaded(this.hotels);

  final List<Hotel> hotels;
}

class HotelDetailsLoaded extends HotelState {
  const HotelDetailsLoaded(this.hotel);

  final HotelDetails hotel;
}
