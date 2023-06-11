import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/api_caller/app_url.dart';

class UserProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? username,
    String? profilePicPath,
    String? userId,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse('${AppUrl.baseUrl}/user/profile/$userId');
      final request = http.MultipartRequest('POST', url);
      request.fields['name'] = name ?? '';
      request.fields['email'] = email ?? '';
      request.fields['username'] = username ?? '';

      // Add profile picture file if available
      if (profilePicPath != null) {
        final profilePicFile = await http.MultipartFile.fromPath(
          'profile_pic',
          profilePicPath,
        );
        request.files.add(profilePicFile);
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        // Profile updated successfully
        print('User profile updated successfully');
      } else {
        // Failed to update profile
        print('Failed to update user profile');
      }
    } catch (error) {
      print('Error updating user profile: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
