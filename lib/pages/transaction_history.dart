import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/api_caller/transactions.dart';


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
    return isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (BuildContext context, int index) {
        final transaction = transactionList[index];
        final sign = transaction['debited'] == true ? '+ ৳' : '- ৳';
        return ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage:
                  iconPicker(transactionList[index]['transactionType'])),
          title: Text(
            transactionList[index]['receiverAccount'],
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
          subtitle: Text(
            transactionList[index]['transactionType'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 34, 17, 17),
            ),
          ),
          trailing: Text(
            '$sign${transaction['amount']}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
