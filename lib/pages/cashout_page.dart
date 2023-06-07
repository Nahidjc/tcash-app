import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rnd_flutter_app/pages/components/amount_confirm.dart';
import 'package:rnd_flutter_app/pages/qr_code_widget.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

class CashoutPage extends StatefulWidget {
  final String? marchantAccount;
  const CashoutPage({Key? key, this.marchantAccount}) : super(key: key);

  @override
  State<CashoutPage> createState() => _CashoutPageState();
}

class _CashoutPageState extends State<CashoutPage> {
  final TextEditingController _marchantNoController = TextEditingController();
  String accountNumber = '';
  // String amount = '';
  // double availableBalance = 500.00;
  @override
  void initState() {
    super.initState();
    if (widget.marchantAccount != null) {
      _marchantNoController.text = widget.marchantAccount!;
    }
  }

  @override
  Widget build(BuildContext context) {
  bool isButtonDisabled = _marchantNoController.text.length != 11;
  bool showError = _marchantNoController.text.isNotEmpty && isButtonDisabled;

  Color borderSideColor = showError
      ? Colors.red
      : Color.fromARGB(255, 2, 183, 255);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
        ),
        title: const Text(
          'Cash Out',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
           TextField(
            maxLength: 11,
            controller: _marchantNoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter Agent Account Number',
              border: OutlineInputBorder(),
              errorText: showError ? 'Account number must be 11 characters' : null,
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
                accountNumber = value;
              });
            },
          ),
            // const SizedBox(height: 16),
            Column(children: [
              const Text(
                'or',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text(
                'Scan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(
                width: 70,
                child: ElevatedButton(
                  child: const Icon(Icons.qr_code),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const QRViewExample(),
                    ));
                  },
                ),
              )
            ]),

            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: isButtonDisabled
                  ? null // Disable the button if the condition is not met
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AmountConfirm(accountNo: _marchantNoController.text),
                      ));
                    },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: borderSideColor),
                  ),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
