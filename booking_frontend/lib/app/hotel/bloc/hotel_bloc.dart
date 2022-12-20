import 'package:booking_frontend/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(const HotelInitial()) {
    on<GetAllHotels>((event, emit) async {
      emit(const HotelLoading());
      hotels = await repository.readAll();
      emit(HotelsLoaded(hotels));
    });

    on<SearchHotel>((event, emit) async {
      emit(const HotelLoading());
      hotels = await repository.search(
        cityController.text,
        int.parse(distanceController.text),
        checkinController.text,
        checkoutController.text,
        int.parse(roomController.text),
      );
      emit(HotelsLoaded(hotels));
    });

    on<GetHotelDetails>((event, emit) async {
      emit(const HotelLoading());
      final hotel = await repository.read(event.id);
      emit(HotelDetailsLoaded(hotel));
    });
  }

  final formKey = GlobalKey<FormState>();
  final cityController = TextEditingController();
  final distanceController = TextEditingController();
  final checkinController = TextEditingController();
  final checkoutController = TextEditingController();
  final roomController = TextEditingController();

  final repository = HotelRepository();
  List<Hotel> hotels = <Hotel>[];
}
