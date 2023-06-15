import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/api_caller/app_url.dart';

class Payments {
  Future paymentCashOut(String accountNumber, String password,
      String receiverNumber, dynamic amount) async {
    final url = Uri.parse('${AppUrl.baseUrl}/payment/cashout');
    final requestData = {
      'accountNumber': accountNumber,
      'password': password,
      'receiverNumber': receiverNumber,
      'amount': amount,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );
      return response;
      // final data = json.decode(response.body);
      // print(data);
      // // return data;
      // if (response.statusCode == 200) {
      //   return true;
      // } else {
      //   return data;
      // }
    } catch (e) {
      return false;
    }
  }
}
