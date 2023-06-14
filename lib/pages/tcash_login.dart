import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/pages/home_page.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:rnd_flutter_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/widgets/custom_progress.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

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

  void setInitialAccountNumber(String accountNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accountNumber', accountNumber);
  }

  Future<String> getInitialAccountNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accountNumber') ?? '';
  }

  @override
  void initState() {
    super.initState();
    retrieveInitialAccountNumber();
  }

  void retrieveInitialAccountNumber() async {
    String initialAccountNumber = await getInitialAccountNumber();
    setState(() {
      _accountNumberController.text = initialAccountNumber;
    });
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Provider.of<AuthProvider>(context, listen: false)
          .loginProvider(_accountNumberController.text, _pinController.text);
      setInitialAccountNumber(_accountNumberController.text);
      _accountNumberController.clear();
      _pinController.clear();
    }
  }

  void _goToRegisterPage() {
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);
    if (authState.isAuthenticated) {
      return const HomePage();
    }
    return Scaffold(
      body: authState.isLoading
          ? const CustomLoadingAnimation()
          : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                Image.asset(
                  'assets/images/tcash.png',
                  width: 100,
                  fit: BoxFit.cover,
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
                if (!authState.isAuthenticated &&
                    authState.errorMessage.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            authState.errorMessage,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                TextFormField(
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  enabled: !authState.isLoading,
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
                  enabled: !authState.isLoading,
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
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: CustomButton(
                          content: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                    onPressed: _submitForm,
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
