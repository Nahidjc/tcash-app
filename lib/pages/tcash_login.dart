import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? _mobileNumber;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    // validator: (value) {
                    //   if (value?.isEmpty ?? true) {
                    //     return 'Please enter your mobile number';
                    //   }
                    //   if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                    //     return 'Please enter a valid mobile number';
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) {
                      _mobileNumber = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    // validator: (value) {
                    //   if (value?.isEmpty ?? true) {
                    //     return 'Please enter your password';
                    //   }
                    //   if (value.length < 6) {
                    //     return 'Password must be at least 6 characters';
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState.validate()) {
                      //   _formKey.currentState.save();
                      //   // TODO: Implement login functionality
                      // }
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
