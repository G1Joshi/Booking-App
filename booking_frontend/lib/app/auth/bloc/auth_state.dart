part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError(this.error);

  final String error;
}

class RegistrationStarted extends AuthState {
  const RegistrationStarted();
}

class SignedUp extends AuthState {
  const SignedUp();
}

class SignedIn extends AuthState {
  const SignedIn();
}

class SignedOut extends AuthState {
  const SignedOut();
}
