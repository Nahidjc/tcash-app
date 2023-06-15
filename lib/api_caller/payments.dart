import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/api_caller/app_url.dart';

class Payments {
  Future<bool> paymentCashOut(String accountNumber, String password,
      String receiverNumber, dynamic amount) async {
    final url = Uri.parse('${AppUrl.baseUrl}/payment/cashout');
    final requestData = {
      'accountNumber': accountNumber,
      'password': password,
      'receiverNumber': receiverNumber,
      'amount': amount,
    };
    print(requestData);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
