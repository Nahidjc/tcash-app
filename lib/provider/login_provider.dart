import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/api_caller/app_url.dart';
import 'dart:async';
import 'package:rnd_flutter_app/model/user_model.dart';
import 'package:rnd_flutter_app/model/jwt_token_util.dart';

class AuthProvider extends ChangeNotifier {
  UserDetails? _userDetails;
  UserDetails? get userDetails => _userDetails;
  bool _isAuthenticated = false;
  bool _isRegistered = false;
  String _errorMessage = '';
  String _userId = '';
  String get userId => _userId;
  String get errorMessage => _errorMessage;
  bool _isLoading = false;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  bool get isRegistered => _isRegistered;
  double? _accountBalance = 0;
  double? get accountBalance => _accountBalance;
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
        var jsonResponse = json.decode(response.body);
        _userDetails = UserDetails.fromJson(jsonResponse['user']);
        _accountBalance = _userDetails?.currentBalance;
        notifyListeners();
        final decryptedData =
            JwtTokenUtil.decryptJwtToken(jsonResponse['token']);
        _userId = decryptedData['id'];
        setLoading(false);
        setAuthenticated(true);
        _errorMessage = '';
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

  Future<void> register(
      String mobileNo, String email, String password, int userTypeIndex) async {
    try {
      final url = Uri.parse('${AppUrl.baseUrl}/register');
      setLoading(true);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'mobileNo': mobileNo,
            'password': password,
            'email': email,
            'userType': userTypeIndex
          },
        ),
      );
      if (response.statusCode == 200) {
        setLoading(false);
        _isRegistered = true;
        _errorMessage = '';
        notifyListeners();
      } else {
        setLoading(false);
        _errorMessage = 'Internal Server Error';
        Timer(const Duration(seconds: 3), () {
          _errorMessage = '';
          notifyListeners();
        });
      }
      notifyListeners();
    } catch (e) {
      setLoading(false);
    }
  }

  void logout() {
    _errorMessage = '';
    _userId = '';
    setAuthenticated(false);
    notifyListeners();
  }
}
