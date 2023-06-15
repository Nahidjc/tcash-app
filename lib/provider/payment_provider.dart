import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/api_caller/payments.dart';

class Transactions extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  TransactionResponse? _transactions;
  TransactionResponse? get transactions => _transactions;

  Future<TransactionResponse> transactionsProvider(mobileNo) async {
    _isLoading = true;
    notifyListeners();
    try {
      final payments = Payments();
      final response = await payments.userExpenditureAndDeposit(mobileNo);
      final transactionResponse =
          TransactionResponse.fromJson(json.decode(response));
      _transactions = transactionResponse;
      _isLoading = false;
      notifyListeners();
      return transactionResponse;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}

class TransactionResponse {
  final double expenditureAmount;
  final double depositAmount;
  final String message;

  TransactionResponse({
    required this.expenditureAmount,
    required this.depositAmount,
    required this.message,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      expenditureAmount: json['expenditureAmount'],
      depositAmount: json['depositAmount'],
      message: json['message'],
    );
  }
}
