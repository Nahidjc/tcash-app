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
    } catch (e) {
      return false;
    }
  }

  Future userExpenditureAndDeposit(String accountNumber) async {
    final url = Uri.parse('${AppUrl.baseUrl}/today/expense');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'accountnumber': accountNumber
    });
    return response;
  }
}
