import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/api_caller/app_url.dart';
import 'dart:convert';

class AccountValidate {
  Future<bool> validateAgent(String accountnumber) async {
    final url = Uri.parse('${AppUrl.baseUrl}/validate/agent');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'accountnumber': accountnumber
      });
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return data['validate'];
      } else {
        return data['validate'];
      }
    } catch (e) {
      return false;
    }
  }
}
