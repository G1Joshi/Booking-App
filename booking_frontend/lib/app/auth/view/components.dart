import 'package:booking_frontend/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: MaterialButton(
        minWidth: 300,
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        textColor: Colors.blue.shade700,
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<AlertDialog?> showRegistrationForm(BuildContext context) async {
  final formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Registration'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              labelText: 'Name',
              controller: context.read<AuthBloc>().nameController,
            ),
            const SizedBox(height: 8),
            InputField(
              labelText: 'Phone',
              controller: context.read<AuthBloc>().phoneController,
            ),
            const SizedBox(height: 8),
            InputField(
              labelText: 'DOB',
              controller: context.read<AuthBloc>().dobController,
            ),
            const SizedBox(height: 8),
            InputField(
              labelText: 'City',
              controller: context.read<AuthBloc>().cityController,
            ),
            const SizedBox(height: 8),
            InputField(
              labelText: 'State',
              controller: context.read<AuthBloc>().stateController,
            ),
            const SizedBox(height: 8),
            InputField(
              labelText: 'Country',
              controller: context.read<AuthBloc>().countryController,
            ),
            const SizedBox(height: 8),
            InputField(
              labelText: 'Pin Code',
              controller: context.read<AuthBloc>().pincodeController,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          Navigator.pop(context);
                          context.read<AuthBloc>().add(const SignUp());
                        }
                      },
                      child: state is AuthLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
