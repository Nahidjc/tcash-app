import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/tcash_login.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:rnd_flutter_app/widgets/custom_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _userType = 'Personal';
  final List<String> _userTypes = ['Personal', 'Agent', 'Merchant'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileNoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String mobileNo = _mobileNoController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      int userTypeIndex = _userTypes.indexOf(_userType);
      Provider.of<AuthProvider>(context, listen: false)
          .register(mobileNo, email, password, userTypeIndex + 1);
      _mobileNoController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    }
  }

  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasFocus) {
        return;
      }
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  void _goToLoginPage() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);
    if (authState.isRegistered) {
      return const LoginPage();
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Image.asset(
                  'assets/images/tcash.png',
                  width: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10.0),
                if (!authState.isRegistered &&
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
                  enabled: !authState.isLoading,
                  controller: _mobileNoController,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.phone_rounded, size: 24),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (value.length != 11) {
                      return 'Mobile number must be exactly 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  enabled: !authState.isLoading,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.email_outlined, size: 24),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  enabled: !authState.isLoading,
                  controller: _passwordController,
                  keyboardType: TextInputType.number,
                  obscureText: _obscured,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.lock_rounded, size: 24),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length != 6) {
                      return 'Password must be exactly 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  enabled: !authState.isLoading,
                  controller: _confirmPasswordController,
                  obscureText: _obscured,
                  keyboardType: TextInputType.number,
                  focusNode: textFieldFocusNode,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.lock_rounded, size: 24),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                DropdownButtonFormField<String>(
                  value: _userType,
                  decoration: InputDecoration(
                    labelText: 'User Type',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  items: _userTypes.map((String userType) {
                    return DropdownMenuItem<String>(
                      value: userType,
                      child: Text(
                        userType,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userType = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a user type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: CustomButton(
                      content: authState.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _submitForm,
                    )),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: _goToLoginPage,
                  child: const Text(
                    "Already have an account? Login here",
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
