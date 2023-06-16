import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/api_caller/transactions.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';

class TransactionHistory extends StatefulWidget {
  final String accountNumber;
  const TransactionHistory({
    Key? key,
    required this.accountNumber,
  }) : super(key: key);
  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool isLoading = false;
  final List<Map<String, dynamic>> transactions = [
    {
      'receiver': 'Nahid Hasan',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '50',
      'type': 'Payment',
      "debited": false
    },
    {
      'receiver': 'Jane Smith',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '20',
      'type': 'Cash In',
      "debited": true
    },
    {
      'receiver': 'Bob Johnson',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '100.00',
      'type': 'Send Money',
      "debited": false
    },
    {
      'receiver': 'Jane Smith',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '20.00',
      'type': 'Recharge',
      "debited": false
    },
    {
      'receiver': 'Bob Johnson',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '100.00',
      'type': 'Send Money',
      "debited": false
    },
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchTransactionHistory();
    });
  }

  List transactionList = [];
  Future<void> fetchTransactionHistory() async {
    setState(() {
      isLoading = true;
    });
    final list =
        await Transaction().fetchTransactionsByAccount(widget.accountNumber);
    transactionList = list;
    setState(() {
      isLoading = false;
    });
  }

  ImageProvider<Object> iconPicker(String type) {
    switch (type) {
      case "Cash Out":
        return const AssetImage(
          'assets/icons/cash_out.png',
        );
      case "Payment":
        return const AssetImage(
          'assets/icons/payment.png',
        );
      case "Send Money":
        return const AssetImage(
          'assets/icons/send.png',
        );
      case "Cash In":
        return const AssetImage(
          'assets/icons/cash_in.png',
        );
      case "Add Money":
        return const AssetImage(
          'assets/icons/add_money.png',
        );
      case "Mobile Recharge":
        return const AssetImage(
          'assets/icons/recharge.png',
        );
      default:
        return const AssetImage(
          'assets/icons/transaction.png',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);
    final userAccountNumber = authState.userDetails?.mobileNo;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (transactionList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.pink,
            ),
            SizedBox(height: 16),
            Text(
              'No transactions found',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (BuildContext context, int index) {
          final transaction = transactionList[index];
          final receiverAccount = transaction['receiverAccount'];
          final senderAccount = transaction['senderAccount'];
          final receiverName = transaction['receiverName'];
          final senderName = transaction['senderName'];
          final receiverTransactionType =
              transaction['receiverTransactionType'];
          final senderTransactionType = transaction['senderTransactionType'];

          final displayAccountNumber = userAccountNumber == receiverAccount
              ? senderAccount
              : receiverAccount;
          final displayName =
              userAccountNumber == receiverAccount ? senderName : receiverName;
          final displayTransactionType = userAccountNumber == receiverAccount
              ? receiverTransactionType
              : senderTransactionType;
          final sign = userAccountNumber == receiverAccount ? '+ ৳' : '- ৳';
          final accountText = displayName ?? displayAccountNumber;
          bool isDebited = userAccountNumber == receiverAccount ? true : false;

          return ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: iconPicker(displayTransactionType)),
            title: Text(
              accountText,
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
            subtitle: Text(
              displayTransactionType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 34, 17, 17),
              ),
            ),
            trailing: Text(
              '$sign${transaction['amount']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDebited ? Colors.green : Colors.pink,
              ),
            ),
          );
        },
      );
    }
  }
}
