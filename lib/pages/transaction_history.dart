import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});
  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final List<Map<String, dynamic>> transactions = [
    {
      'receiver': 'John Doe',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '\$50.00',
      'type': 'Online'
    },
    {
      'receiver': 'Jane Smith',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '\$20.00',
      'type': 'Offline'
    },
    {
      'receiver': 'Bob Johnson',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '\$100.00',
      'type': 'Online'
    },
    {
      'receiver': 'Jane Smith',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '\$20.00',
      'type': 'Offline'
    },
    {
      'receiver': 'Bob Johnson',
      'picture': 'https://avatars.githubusercontent.com/u/113003788',
      'amount': '\$100.00',
      'type': 'Online'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(transactions[index]['picture']),
          ),
          title: Text(transactions[index]['receiver']),
          subtitle: Text(transactions[index]['type']),
          trailing: Text(transactions[index]['amount']),
        );
      },
    );
  }
}
