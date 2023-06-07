import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/pages/components/password_confirm.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'dart:developer' as dev;

class ConfirmationData {
  final double amount;
  final String accountNo;
  final double remainingBalance;

  ConfirmationData(this.amount, this.accountNo, this.remainingBalance);
}

class AmountConfirm extends StatefulWidget {
  final String? accountNo;

  const AmountConfirm({Key? key, this.accountNo}) : super(key: key);

  @override
  State<AmountConfirm> createState() => _AmountConfirmState();
}

class _AmountConfirmState extends State<AmountConfirm> {
  final TextEditingController _amountController = TextEditingController();
  String amount = '';
  double availableBalance = 500.00;
  double remainingBalance = 0;

  @override
  void initState() {
  debugPrint(widget.accountNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonDisabled = _amountController.text.isEmpty ||
        double.tryParse(_amountController.text) == null ||
        double.parse(_amountController.text) > availableBalance;
    bool showError = _amountController.text.isNotEmpty && isButtonDisabled;

    Color borderSideColor =
        showError ? Colors.red : Color.fromARGB(255, 2, 183, 255);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade300,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.cashout);
            },
          ),
          title: const Text(
            'Amount Confirm',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: [
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    border: OutlineInputBorder(),
                    errorText: showError
                        ? 'Amount must be less or equal to current balance'
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderSideColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderSideColor),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      amount = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Available Balance: \$${availableBalance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: isButtonDisabled
                        ? null
                        : () {
                            ConfirmationData data = ConfirmationData(
                              double.parse(_amountController.text),
                              widget.accountNo as String,
                              (availableBalance-double.parse(_amountController.text)),
                            );
                            confirmAmount(data);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 2, 183, 255)),
                      ),
                    ),
                    child: const Text('Next'),
                  ),
                ),
              ],
            )));
  }

  void confirmAmount(ConfirmationData data) async {
     Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => PasswordConfirm(accountNo: data.accountNo, amount: data.amount,remainingBalance:data.remainingBalance),
    ));
  }
}
