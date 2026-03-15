import 'package:booking_frontend/config/config.dart';
import 'package:booking_frontend/data/data.dart';
import 'package:booking_models/booking_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<CheckAuth>((event, emit) async {
      emit(const AuthLoading());
      try {
        if (Storage.prefs.getString('access_token') != null) {
          emit(const SignedIn());
        } else {
          emit(const AuthInitial());
        }
      } on Object catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<StartRegistration>((event, emit) async {
      emit(const AuthLoading());
      try {
        emit(const RegistrationStarted());
      } on Object catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignUp>((event, emit) async {
      emit(const AuthLoading());
      try {
        final response = await _repository.signUp(
          User(
            id: _getId(),
            name: event.name,
            email: event.email,
            password: event.password,
            profileImage: _getAvatar(event.name),
            phone: event.phone,
            dateOfBirth: event.dob,
            city: event.city,
            state: event.state,
            country: event.country,
            pincode: event.pincode,
          ),
        );
        if (response) {
          emit(const SignedUp());
        }
      } on Object catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<StartLogin>((event, emit) async {
      emit(const AuthLoading());
      try {
        emit(const LoginStarted());
      } on Object catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignIn>((event, emit) async {
      emit(const AuthLoading());
      try {
        final token = await _repository.signIn(
          LoginRequest(
            email: event.email,
            password: event.password,
          ),
        );
        if (token != null) {
          await Storage.prefs.setString('access_token', token.accessToken);
          emit(const SignedIn());
        } else {
          emit(const SignedOut());
        }
      } on Object catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(const AuthLoading());
      try {
        await Storage.prefs.clear();
        emit(const SignedOut());
      } on Object catch (error) {
        emit(AuthError(error.toString()));
      }
    });
  }

  String _getAvatar(String name) {
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e[0]).take(2).join()
        : 'U';
    const avatarUrl = 'https://ui-avatars.com/api/?name=';
    return '$avatarUrl$initials&background=random&size=128';
  }

  String _getId() {
    return const Uuid().v4();
  }

  final _repository = AuthRepository();
}
