import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/components/password_confirm.dart';
import 'package:rnd_flutter_app/provider/user_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:rnd_flutter_app/widgets/custom_button.dart';

class ConfirmationData {
  final double amount;
  final String accountNo;
  final double remainingBalance;
  final double charge;

  ConfirmationData(
      this.amount, this.accountNo, this.remainingBalance, this.charge);
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
  double availableBalance = 0;
  double remainingBalance = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final userDetails =
        Provider.of<UserProvider>(context, listen: false).userDetails;
    availableBalance = userDetails?.currentBalance ?? 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Amount',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount.';
                    }
                    double enteredAmount = double.tryParse(value) ?? 0.0;
                    double calculatedAmount =
                        calculateAmountWithPercentage(enteredAmount);
                    if (calculatedAmount > availableBalance) {
                      return 'Amount exceeds available balance.';
                    }
                    return null;
                  },
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: CustomButton(
                    content: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ConfirmationData data = ConfirmationData(
                            double.parse(_amountController.text),
                            widget.accountNo as String,
                            calculateRemainingBalance(availableBalance,
                                double.parse(_amountController.text)),
                            calculateCharge(
                                double.parse(_amountController.text)));
                        confirmAmount(data);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void confirmAmount(ConfirmationData data) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PasswordConfirm(
          accountNo: data.accountNo,
          amount: data.amount,
          remainingBalance:
              double.parse(data.remainingBalance.toStringAsFixed(2)),
          charge: data.charge),
    ));
  }

  double calculateAmountWithPercentage(double amount) {
    double result = amount + (0.0099 * amount);
    return double.parse(result.toStringAsFixed(2));
  }

  double calculateCharge(double amount) {
    double chargePercentage = 0.0099;
    double charge = amount * chargePercentage;
    return double.parse(charge.toStringAsFixed(2));
  }

  double calculateRemainingBalance(double currentBalance, double amount) {
    double deductionAmount = amount + (0.0099 * amount);
    double roundedDeduction = double.parse(deductionAmount.toStringAsFixed(2));
    return currentBalance - roundedDeduction;
  }
}
