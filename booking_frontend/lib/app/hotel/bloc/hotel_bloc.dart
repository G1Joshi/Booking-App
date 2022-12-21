import 'package:booking_frontend/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(const HotelInitial()) {
    on<GetAllHotels>((event, emit) async {
      emit(const HotelsLoading());
      hotels = await repository.readAll();
      emit(HotelsLoaded(hotels));
    });

    on<SearchHotel>((event, emit) async {
      emit(const HotelsSearching());
      hotels = await repository.search(
        cityController.text,
        int.parse(distanceController.text),
        checkinController.text,
        checkoutController.text,
        int.parse(roomController.text),
      );
      emit(HotelsLoaded(hotels));
    });

    on<FilterHotel>((event, emit) async {
      var star = '';
      var rating = '';
      var propertyType = '';
      var budget = '';
      for (final element in FilterModel.starCategory) {
        if (element.isSelected) star += ',${element.value}';
      }
      for (final element in FilterModel.userRating) {
        if (element.isSelected) rating += ',${element.value}';
      }
      for (final element in FilterModel.propertyType) {
        if (element.isSelected) propertyType += ',${element.value}';
      }
      for (final element in FilterModel.budget) {
        if (element.isSelected) budget += ',${element.value}';
      }
      emit(const HotelsLoading());
      star = star.split(',').skip(1).join(',');
      rating = rating.split(',').skip(1).join(',');
      propertyType = propertyType.split(',').skip(1).join(',');
      budget = budget.split(',').skip(1).join(',');
      if (star == '' && rating == '' && propertyType == '' && budget == '') {
        hotels = await repository.readAll();
      } else {
        hotels = hotels = await repository.filter(
          star,
          rating,
          propertyType,
          budget,
        );
      }
      emit(HotelsLoaded(hotels));
    });

    on<GetHotelDetails>((event, emit) async {
      emit(const HotelsLoading());
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
