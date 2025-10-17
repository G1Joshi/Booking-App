import 'package:booking_frontend/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AuthBloc>(context)..add(const CheckAuth()),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is RegistrationStarted) {
          await showRegistrationForm(context);
        } else if (state is SignedUp) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful, Please login'),
            ),
          );
        } else if (state is SignedIn) {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute<HotelPage>(
              builder: (context) => const HotelPage(),
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade700,
                  Colors.blue.shade500,
                ],
              ),
            ),
            child: Center(
              child: state is AuthLoading
                  ? const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthButton(
                          text: 'Sign Up With Google',
                          icon: Icons.android,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              const StartRegistration(),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        AuthButton(
                          text: 'Sign In With Google',
                          icon: Icons.android,
                          onPressed: () {
                            context.read<AuthBloc>().add(const SignIn());
                          },
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
