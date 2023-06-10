import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnd_flutter_app/api_caller/app_url.dart';
import 'package:rnd_flutter_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserDetails? _userDetails;
  UserDetails? get userDetails => _userDetails;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<UserDetails> fetchUserDetailsById(String userId) async {
    final url = Uri.parse('${AppUrl.baseUrl}/user/$userId');

    try {
      _isLoading = true;
      notifyListeners();
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        // _userDetails = UserDetails.fromJson(data['user']);
        final user = UserDetails.fromJson(data['user']);
        _isLoading = false;
        notifyListeners();
        return user;
      } else {
        throw Exception('Failed to fetch user details');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUserData() {
    _userDetails = null;
    notifyListeners();
  }
}
