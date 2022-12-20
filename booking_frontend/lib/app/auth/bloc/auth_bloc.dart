import 'package:booking_frontend/config/config.dart';
import 'package:booking_frontend/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) => currentUser = account,
    );

    on<CheckAuth>((event, emit) async {
      emit(const AuthLoading());
      try {
        if (Storage.prefs.getString('access_token') != null) {
          final data = await googleSignIn.signInSilently();
          final auth = await data?.authentication;
          final accessToken = auth?.accessToken;
          if (accessToken != null) {
            await Storage.prefs.setString('access_token', accessToken);
          }
        }
        if (googleSignIn.currentUser != null) {
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
        final data = await googleSignIn.signIn();
        final id = data?.id;
        if (id != null) {
          emit(const RegistrationStarted());
        }
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignUp>((event, emit) async {
      emit(const AuthLoading());
      try {
        final response = await repository.signUp(
          User(
            id: currentUser!.id,
            name: nameController.text,
            email: currentUser!.email,
            profileImage: currentUser!.photoUrl,
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

    on<SignIn>((event, emit) async {
      emit(const AuthLoading());
      try {
        final data = await googleSignIn.signIn();
        final auth = await data?.authentication;
        final accessToken = auth?.accessToken;
        final idToken = auth?.idToken;
        if (accessToken != null && idToken != null) {
          final response = await repository.signIn(
            Token(idToken: idToken),
          );
          if (response) {
            await Storage.prefs.setString('access_token', accessToken);
            emit(const SignedIn());
          } else {
            emit(const SignedOut());
          }
        }
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(const AuthLoading());
      try {
        await Storage.prefs.clear();
        await googleSignIn.signOut();
        emit(const SignedOut());
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });
  }

  static GoogleSignInAccount? currentUser;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodeController = TextEditingController();

  final repository = AuthRepository();
  final googleSignIn = GoogleSignIn(
    clientId: dotenv.get('clientId'),
    scopes: ['email', 'profile'],
  );
}
