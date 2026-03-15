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

class StartLogin extends AuthEvent {
  const StartLogin();
}

class SignUp extends AuthEvent {
  const SignUp({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.dob,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
  });

  final String name;
  final String email;
  final String password;
  final int phone;
  final String dob;
  final String city;
  final String state;
  final String country;
  final int pincode;

  @override
  List<Object> get props => [
    name,
    email,
    password,
    phone,
    dob,
    city,
    state,
    country,
    pincode,
  ];
}

class SignIn extends AuthEvent {
  const SignIn({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent {
  const SignOut();
}
