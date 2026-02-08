import 'package:booking_frontend/config/config.dart';
import 'package:booking_frontend/data/data.dart';
import 'package:booking_models/booking_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<StartRegistration>((event, emit) async {
      emit(const AuthLoading());
      try {
        emit(const RegistrationStarted());
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignUp>((event, emit) async {
      emit(const AuthLoading());
      try {
        final response = await repository.signUp(
          User(
            id: getId(),
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            profileImage: getAvatar(nameController.text),
            phone: int.parse(phoneController.text),
            dateOfBirth: dobController.text,
            city: cityController.text,
            state: stateController.text,
            country: countryController.text,
            pincode: int.parse(pincodeController.text),
          ),
        );
        if (response) {
          emit(const SignedUp());
        }
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<StartLogin>((event, emit) async {
      emit(const AuthLoading());
      try {
        emit(const LoginStarted());
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignIn>((event, emit) async {
      emit(const AuthLoading());
      try {
        final token = await repository.signIn(
          LoginRequest(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
        if (token != null) {
          await Storage.prefs.setString('access_token', token.accessToken);
          emit(const SignedIn());
        } else {
          emit(const SignedOut());
        }
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(const AuthLoading());
      try {
        await Storage.prefs.clear();
        emit(const SignedOut());
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });
  }

  String getAvatar(String name) {
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e[0]).take(2).join()
        : 'U';
    final avatarUrl =
        'https://ui-avatars.com/api/?name=$initials&background=random&size=128';
    return avatarUrl;
  }

  String getId() {
    return const Uuid().v4();
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodeController = TextEditingController();

  final repository = AuthRepository();
}
