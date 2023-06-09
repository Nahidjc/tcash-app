import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/api_caller/app_url.dart';
import 'dart:async'; 
class AuthProvider extends ChangeNotifier {
  // String _token = '';
  // String get token => _token;
  // // String _username = '';
  // // String get username => _username;
  // bool _loading = false;
  // bool get isLoading => _loading;
  // bool _isAuthenticate = false;
  // bool get isAuthenticate => _isAuthenticate;
  bool _isAuthenticated = false;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  bool _isLoading = false;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginProvider(String phoneNumber, String password) async {
    
    try {
      final url = Uri.parse('${AppUrl.baseUrl}/login');
      setLoading(true);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'mobileNo': phoneNumber,
            'password': password,
          },
        ),
      );
      
      if (response.statusCode == 200) {
        print("success");
        setLoading(false);
        setAuthenticated(true);
        _errorMessage = '';
        // setAuthenticate(true);
        // final userData = UserModel.fromJson(json.decode(response.body));
        // _token = userData.accessToken;
        // _username = userData.user.userName;
      } else {
        setAuthenticated(false);
        _errorMessage = 'Invalid mobile number or password';
        Timer(const Duration(seconds: 3), () {
          _errorMessage = '';
          notifyListeners();
        });
      }
      notifyListeners();
    } catch (e) {
      setLoading(false);

    } finally {
      setLoading(false);
    }
  }

  void logout() {
    _errorMessage = '';
    setAuthenticated(false);
    notifyListeners();
  }
}
