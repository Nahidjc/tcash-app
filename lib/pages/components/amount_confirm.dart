import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

class AmountConfirm extends StatefulWidget {
  final String? accountNo;

  const AmountConfirm({Key? key, this.accountNo}) : super(key: key);

  @override
  State<AmountConfirm> createState() => _AmountConfirmState();
}

class _AmountConfirmState extends State<AmountConfirm> {
  String amount = '';
  double availableBalance = 500.00;

  @override
  void initState() {
  debugPrint(widget.accountNo);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 3, 128, 121),
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
        body: Padding(padding: const EdgeInsets.all(26.0), child: Column(
          children: [
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
                   Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AmountConfirm(),
                  ));
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
}
