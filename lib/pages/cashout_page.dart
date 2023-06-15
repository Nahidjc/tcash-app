import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/api_caller/validate_account.dart';
import 'package:rnd_flutter_app/pages/components/amount_confirm.dart';
import 'package:rnd_flutter_app/pages/qr_code_widget.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:rnd_flutter_app/widgets/custom_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CashoutPage extends StatefulWidget {
  final String? marchantAccount;
  const CashoutPage({Key? key, this.marchantAccount}) : super(key: key);

  @override
  State<CashoutPage> createState() => _CashoutPageState();
}

class _CashoutPageState extends State<CashoutPage> {
  final TextEditingController _marchantNoController = TextEditingController();
  String accountNumber = '';
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.marchantAccount != null) {
      _marchantNoController.text = widget.marchantAccount!;
    }
  }

  validateAgentAccount(String agentAccount) async {
    setState(() {
      isLoading = true;
    });
    bool isValid = await AccountValidate().validateAgent(agentAccount);
    setState(() {
      isLoading = false;
    });

    if (isValid) {
      navigateToAmountConfirm(agentAccount);
    } else {
      showToastNotValid();
    }
  }

  navigateToAmountConfirm(String agentAccount) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AmountConfirm(accountNo: agentAccount),
        ),
      );
    });
  }

  void showToastNotValid() {
    Fluttertoast.showToast(
      msg: 'Agent account not valid',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(26.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              TextFormField(
                maxLength: 11,
                controller: _marchantNoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Agent Account Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter an agent account number';
                  }
                  if (value?.length != 11) {
                    return 'Account number must be exactly 11 digits';
                  }

                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    accountNumber = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Scan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    width: 70,
                    child: ElevatedButton(
                      child: const Icon(Icons.qr_code),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QRViewExample(),
                        ));
                      },
                    ),
                  ),
                ],
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
                    if (_formKey.currentState?.validate() ?? false) {
                      validateAgentAccount(_marchantNoController.text);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
