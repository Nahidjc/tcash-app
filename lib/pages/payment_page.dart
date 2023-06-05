import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

class PaymentPage extends StatefulWidget {
  final String? marchantAccount;
  const PaymentPage({Key? key, this.marchantAccount}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _marchantNoController = TextEditingController();
  String accountNumber = '';
  String amount = '';
  double availableBalance = 500.00;
  @override
  void initState() {
    super.initState();
    if (widget.marchantAccount != null) {
      _marchantNoController.text = widget.marchantAccount!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 128, 121),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
        ),
        title: const Text(
          'Marchant Payment',
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
              decoration: const InputDecoration(
                labelText: 'Enter Marchant Account Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  accountNumber = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 5,
              decoration: const InputDecoration(
                labelText: 'Enter amount',
                border: OutlineInputBorder(),
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
                onPressed: () {
                  // Perform payment logic here
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
        ),
      ),
    );
  }
}
