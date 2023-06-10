import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:rnd_flutter_app/widgets/custom_appbar.dart';
import 'package:rnd_flutter_app/widgets/custom_button.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({Key? key}) : super(key: key);

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double availableBalance = 500.00; // Replace with actual balance
  String phoneNumber = '';

  @override
  void dispose() {
    _accountNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String accountNumber = _accountNumberController.text;
      double amount = double.parse(_amountController.text);
      _accountNumberController.clear();
      _amountController.clear();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  String? _validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your account number';
    }
    if (value.length != 11) {
      return 'Account number must be exactly 11 digits';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the amount';
    }
    double amount = double.tryParse(value) ?? 0;
    if (amount <= 0) {
      return 'Amount must be greater than zero';
    }
    if (amount > availableBalance) {
      return 'Amount exceeds available balance';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          content: Text(
        "Send Money",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      controller: _accountNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Account Number',
                      ),
                      validator: _validateAccountNumber,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.contacts),
                      onPressed: () async {
                        final PhoneContact contact =
                            await FlutterContactPicker.pickPhoneContact();
                        setState(() {
                          phoneNumber = contact.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 5,
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                validator: _validateAmount,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Available Balance: \$${availableBalance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  content: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
