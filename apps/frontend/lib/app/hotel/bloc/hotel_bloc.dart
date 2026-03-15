import 'package:booking_frontend/data/data.dart';
import 'package:booking_models/booking_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(const HotelInitial()) {
    on<GetAllHotels>((event, emit) async {
      emit(const HotelsLoading());
      final hotels = await _repository.readAll();
      emit(HotelsLoaded(hotels));
    });

    on<SearchHotel>((event, emit) async {
      emit(const HotelsSearching());
      final hotels = await _repository.search(
        event.city,
        event.distance,
        event.checkin,
        event.checkout,
        event.rooms,
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

      List<Hotel> hotels;
      if (star == '' && rating == '' && propertyType == '' && budget == '') {
        hotels = await _repository.readAll();
      } else {
        hotels = await _repository.filter(
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
      final hotel = await _repository.read(event.id);
      emit(HotelDetailsLoaded(hotel));
    });

    on<AddBooking>((event, emit) async {
      emit(const HotelsLoading());
      await _repository.addBooking(
        event.hotelId,
        event.roomId,
        event.checkin,
        event.checkout,
        event.roomCount,
        event.guestCount,
      );
      add(GetHotelDetails(event.hotelId));
    });

    on<AddReview>((event, emit) async {
      emit(const HotelsLoading());
      await _repository.addReview(
        event.hotelId,
        event.rating,
        event.review,
      );
      add(GetHotelDetails(event.hotelId));
    });

    on<DeleteReview>((event, emit) async {
      emit(const HotelsLoading());
      await _repository.deleteReview(event.hotelId, event.reviewId);
      add(GetHotelDetails(event.hotelId));
    });
  }

  final _repository = HotelRepository();
}
