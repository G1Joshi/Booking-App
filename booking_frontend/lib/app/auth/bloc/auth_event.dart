part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuth extends AuthEvent {
  const CheckAuth();
}

class StartRegistration extends AuthEvent {
  const StartRegistration();
}

class SignUp extends AuthEvent {
  const SignUp();
}

class SignIn extends AuthEvent {
  const SignIn();
}

class SignOut extends AuthEvent {
  const SignOut();
}
