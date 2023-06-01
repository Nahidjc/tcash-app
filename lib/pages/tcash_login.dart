import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _accountNumberController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String accountNumber = _accountNumberController.text;
      String pin = _pinController.text;
      _accountNumberController.clear();
      _pinController.clear();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void _goToRegisterPage() {
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                const FlutterLogo(
                  size: 80.0,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Log In to your Tcash account',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Account Number',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.phone_rounded, size: 24),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your account number';
                    }
                    if (value.length != 11) {
                      return 'Account number must be exactly 11 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 6,
                  decoration: InputDecoration(
                      labelText: 'Tcash PIN',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.lock, size: 24)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Pin number';
                    }
                    if (value.length != 6) {
                      return 'Pin number must be exactly 6 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    // Handle forget PIN logic here
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Forget PIN?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: _goToRegisterPage,
                  child: const Text(
                    "Don't have an account? Register here",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
