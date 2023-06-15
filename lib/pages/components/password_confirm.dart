import 'dart:async';
import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/api_caller/payments.dart';
import 'package:rnd_flutter_app/pages/home_page.dart';
import 'package:rnd_flutter_app/provider/user_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordConfirm extends StatefulWidget {
  final String? accountNo;
  final double? amount;
  final double? remainingBalance;
  final double? charge;

  const PasswordConfirm(
      {Key? key,
      this.accountNo,
      this.amount,
      this.remainingBalance,
      this.charge})
      : super(key: key);

  @override
  State<PasswordConfirm> createState() => _PasswordConfirmState();
}

class _PasswordConfirmState extends State<PasswordConfirm> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  late Timer _timer;
  bool _isLongPressed = false; // ignore: unused_field
  late DateTime _startTime;
  double _progressValue = 0.0;
  bool isLoading = false;
  final sign = '৳';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    pinController.dispose();
    super.dispose();
  }

  _showSuccessAlert(String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: message,
      onConfirmBtnTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        ).then(
            (value) => Navigator.of(context).popAndPushNamed(AppRoutes.home));
      },
    );
  }

  void _startTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      final elapsedTime = DateTime.now().difference(_startTime);
      setState(() {
        _progressValue = elapsedTime.inMilliseconds / 2000.0;
      });
      if (elapsedTime >= const Duration(seconds: 2)) {
        _stopTimer();
        setState(() {
          _isLongPressed = true;
        });
        _progressValue = 0.0;
        setState(() {
          isLoading = true;
        });
        createPayment();
        pinController.clear();
      }
    });
  }

  Future<void> createPayment() async {
    final user = Provider.of<UserProvider>(context, listen: false).userDetails;
    final mobileNo = user?.mobileNo;
    if (mobileNo != null) {
      final payments = Payments();
      final response = await payments.paymentCashOut(
        mobileNo,
        pinController.text,
        widget.accountNo.toString(),
        widget.amount,
      );
      final data = json.decode(response.body);
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        _showSuccessAlert(data["message"]);
      } else {
        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void _stopTimer() {
    _timer.cancel();
    _progressValue = 0.0;
    setState(() {
      _isLongPressed = false;
    });
  }

  bool isButtonEnabled = false;
  void _validatePin() {
    if (pinController.text.length == 6) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
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
        body: Container(
          padding: const EdgeInsets.all(26.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Receiver Account:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  '${widget.accountNo}',
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Amount:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  '$sign ${widget.amount}',
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Remaining Balance:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  '$sign ${widget.remainingBalance}',
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Charge:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  '$sign ${widget.charge}',
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Center(
                        child: Pinput(
                            controller: pinController,
                            length: 6,
                            focusNode: focusNode,
                            onChanged: (_) => _validatePin(),
                            obscureText: true,
                            obscuringWidget: Icon(
                              Icons.circle,
                              color: Colors.pink.shade300,
                            ),
                            defaultPinTheme: defaultPinTheme,
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
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
                            )),
                      ),
                      const SizedBox(height: 32.0),
                      LinearProgressIndicator(
                        value: _progressValue,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                        backgroundColor: Colors.grey[200],
                      ),
                      const SizedBox(height: 32.0),
                      Center(
                        child: GestureDetector(
                          onTapDown: (_) =>
                              isButtonEnabled ? _startTimer() : null,
                          onTapUp: (_) => isButtonEnabled ? _stopTimer() : null,
                          onTapCancel: () =>
                              isButtonEnabled ? _stopTimer() : null,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Validate'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
