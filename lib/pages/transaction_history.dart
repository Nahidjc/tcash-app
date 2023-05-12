import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});
  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
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
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (BuildContext context, int index) {
        final transaction = transactions[index];
        final sign = transaction['debited'] == true ? '+ ৳' : '- ৳';
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(transactions[index]['picture']),
          ),
          title: Text(
            transactions[index]['receiver'],
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
          subtitle: Text(
            transactions[index]['type'],
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
