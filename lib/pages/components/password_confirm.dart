import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:pinput/pinput.dart';

class PasswordConfirm extends StatefulWidget {
  final String? accountNo;
  final double? amount;
  final double? remainingBalance;

  const PasswordConfirm(
      {Key? key, this.accountNo, this.amount, this.remainingBalance})
      : super(key: key);

  @override
  State<PasswordConfirm> createState() => _PasswordConfirmState();
}

class _PasswordConfirmState extends State<PasswordConfirm> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  late Timer _timer;
  bool _isLongPressed = false;
  late DateTime _startTime;
  double _progressValue = 0.0;

  @override
  void initState() {
    debugPrint('amount is ${widget.amount}');
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      // Calculate the elapsed time
      final elapsedTime = DateTime.now().difference(_startTime);
      // Update the progress value based on the elapsed time
      setState(() {
        _progressValue = elapsedTime.inMilliseconds / 3000.0;
      });
      if (elapsedTime >= const Duration(seconds: 3)) {
        _stopTimer();
        setState(() {
          _isLongPressed = true;
        });
        _progressValue = 0.0;
        print('Long press action triggered!');
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
    _progressValue = 0.0;
    setState(() {
      _isLongPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var focusedBorderColor = const Color.fromARGB(255, 106, 37, 60);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    var borderColor = Colors.pink.shade300;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
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
            'Password Confirmation',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(26.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Receiver Account:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '${widget.accountNo}',
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Amount:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '${widget.amount}',
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Remaining Balance:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '${widget.remainingBalance}',
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 32.0),
              Pinput(
                controller: pinController,
                length: 6,
                focusNode: focusNode,
                obscureText: true,
                obscuringWidget: Icon(
                  Icons.circle,
                  color: Colors.pink.shade300,
                ),
                // androidSmsAutofillMethod:
                //   AndroidSmsAutofillMethod.smsUserConsentApi,
                // listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                validator: (value) {
                  return value == '000000' ? null : 'Pin is incorrect';
                },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
              const SizedBox(height: 32.0),
              LinearProgressIndicator(
                value: _progressValue,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(height: 32.0),
              Center(
                  child: GestureDetector(
                onTapDown: (_) => _startTimer(),
                onTapUp: (_) => _stopTimer(),
                onTapCancel: () => _stopTimer(),
                child: TextButton(
                  // onLongPress: () {
                  //   debugPrint("confirmed CLICKED");
                  // },
                  onPressed: () {
                    // focusNode.unfocus();
                    // debugPrint("confirmed CLICKED");
                  },
                  child: const Text('Validate'),
                ),
              ))
            ])));
  }
}
