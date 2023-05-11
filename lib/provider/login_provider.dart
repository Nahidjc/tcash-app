import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  String _token = '';
  String get token => _token;
  String _username = '';
  String get username => _username;
  bool _loading = false;
  bool get isLoading => _loading;
  bool _isAuthenticate = false;
  bool get isAuthenticate => _isAuthenticate;
  setAuthenticate(bool value) {
    _isAuthenticate = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginProvider(String emailTXt, String passwordTxt) async {
    try {
      final url =
          Uri.parse('https://e-commerce-service-node.onrender.com/user/login');
      setLoading(true);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': emailTXt,
            'password': passwordTxt,
          },
        ),
      );
      setLoading(false);
      if (response.statusCode == 200) {
        setAuthenticate(true);
        final userData = UserModel.fromJson(json.decode(response.body));
        _token = userData.accessToken;
        _username = userData.user.userName;
      }

      notifyListeners();
    } catch (e) {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    setAuthenticate(false);
    _token = '';
    notifyListeners();
  }
}
