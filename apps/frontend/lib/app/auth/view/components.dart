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
            Icon(icon, size: 40),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showRegistrationForm(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => const _RegistrationDialog(),
  );
}

class _RegistrationDialog extends StatefulWidget {
  const _RegistrationDialog();

  @override
  State<_RegistrationDialog> createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<_RegistrationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _pincodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registration'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(labelText: 'Name', controller: _nameController),
              const SizedBox(height: 8),
              InputField(labelText: 'Email', controller: _emailController),
              const SizedBox(height: 8),
              InputField(
                labelText: 'Password',
                controller: _passwordController,
              ),
              const SizedBox(height: 8),
              InputField(labelText: 'Phone', controller: _phoneController),
              const SizedBox(height: 8),
              InputField(labelText: 'DOB', controller: _dobController),
              const SizedBox(height: 8),
              InputField(labelText: 'City', controller: _cityController),
              const SizedBox(height: 8),
              InputField(labelText: 'State', controller: _stateController),
              const SizedBox(height: 8),
              InputField(labelText: 'Country', controller: _countryController),
              const SizedBox(height: 8),
              InputField(labelText: 'Pin Code', controller: _pincodeController),
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
                          if (_formKey.currentState?.validate() ?? false) {
                            Navigator.pop(context);
                            context.read<AuthBloc>().add(
                              SignUp(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                phone: int.parse(_phoneController.text),
                                dob: _dobController.text,
                                city: _cityController.text,
                                state: _stateController.text,
                                country: _countryController.text,
                                pincode: int.parse(_pincodeController.text),
                              ),
                            );
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
}

Future<void> showLoginForm(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => const _LoginDialog(),
  );
}

class _LoginDialog extends StatefulWidget {
  const _LoginDialog();

  @override
  State<_LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<_LoginDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Login'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(labelText: 'Email', controller: _emailController),
            const SizedBox(height: 8),
            InputField(labelText: 'Password', controller: _passwordController),
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
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.pop(context);
                          context.read<AuthBloc>().add(
                            SignIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
                      child: state is AuthLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Login',
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
    );
  }
}
