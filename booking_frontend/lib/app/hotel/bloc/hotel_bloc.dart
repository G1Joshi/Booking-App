import 'package:booking_frontend/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(const HotelInitial()) {
    final repository = HotelRepository();
    var hotels = <Hotel>[];

    on<GetAllHotels>((event, emit) async {
      emit(const HotelLoading());
      hotels = await repository.readAll();
      emit(HotelsLoaded(hotels));
    });

    on<SearchHotel>((event, emit) async {
      emit(const HotelLoading());
      hotels = await repository.search(
        event.city,
        event.checkin,
        event.checkout,
        event.rooms,
      );
      emit(HotelsLoaded(hotels));
    });
  }
}
