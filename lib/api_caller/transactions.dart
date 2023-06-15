import 'dart:convert';

import 'app_url.dart';
import 'package:http/http.dart' as http;

class Transaction {
  Future fetchTransactionsByAccount(String accounNumber) async {
   final url = Uri.parse('${AppUrl.baseUrl}/transactions');
   try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'accountnumber': accounNumber
      });
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return data['transactions'];
      } else {
        return data['transactions'];
      }
   } catch (e) {
     return false;
   }
  }
}