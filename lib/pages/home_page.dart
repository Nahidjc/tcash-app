import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/api_caller/payments.dart';
import 'package:rnd_flutter_app/pages/app_drawer.dart';
import 'package:rnd_flutter_app/pages/qr_code_widget.dart';
import 'package:rnd_flutter_app/pages/tcash_login.dart';
import 'package:rnd_flutter_app/pages/transaction_history.dart';
import 'package:rnd_flutter_app/pages/user_profile.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/provider/payment_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:rnd_flutter_app/widgets/coming_soon.dart';
import 'package:rnd_flutter_app/widgets/home_appbar.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class GridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const GridItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final parentWidth = constraints.maxWidth;
        final parentHeight = constraints.maxHeight;

        final iconSize = parentHeight * 0.45;
        final textSize = parentHeight * 0.12;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: parentWidth,
            height: parentHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.pink.shade300,
                  size: iconSize,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.pink.shade400,
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  bool isLoadingPayment = false;
  double expenditureAmount = 0;
  double depositAmount = 0;
  @override
  void initState() {
    super.initState();
    userExpenditureAndDeposits();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> userExpenditureAndDeposits() async {
    setState(() {
      isLoadingPayment = true;
    });
    try {
      final authState = Provider.of<AuthProvider>(context, listen: false);
      final payments = Payments();
      final response = await payments
          .userExpenditureAndDeposit(authState.userDetails!.mobileNo!);
      final data = TransactionResponse.fromJson(json.decode(response.body));
      setState(() {
        isLoadingPayment = false;
        expenditureAmount = data.expenditureAmount;
        depositAmount = data.depositAmount;
      });
    } catch (e) {
      setState(() {
        isLoadingPayment = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);
    if (!authState.isAuthenticated) {
      return const LoginPage();
    }
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: const AppDrawer(),
        ),
        appBar:
            MyAppBar(userId: authState.userId, openAppDrawer: openAppDrawer),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    children: [
                      GridItem(
                          key: UniqueKey(),
                          title: 'Send Money',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.sendmoney);
                          },
                          icon: Icons.swap_horizontal_circle),
                      GridItem(
                          key: UniqueKey(),
                          title: 'Add Money',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ComingSoonPage(featureName: 'Add Money'),
                              ),
                            );
                          },
                          icon: Icons.attach_money),
                      GridItem(
                          key: UniqueKey(),
                          title: 'Cash Out',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.cashout);
                          },
                          icon: Icons.monetization_on),
                      GridItem(
                          key: UniqueKey(),
                          title: 'Payment',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.payment);
                          },
                          icon: Icons.payment),
                      GridItem(
                          key: UniqueKey(),
                          title: 'Pay Bill',
                          icon: Icons.receipt_long,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ComingSoonPage(featureName: "Pay Bill"),
                              ),
                            );
                          }),
                      GridItem(
                          key: UniqueKey(),
                          title: 'Mobile Recharge',
                          icon: Icons.phone_android,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComingSoonPage(
                                    featureName: "Mobile Recharge"),
                              ),
                            );
                          }),
                      GridItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ComingSoonPage(featureName: "Savings"),
                            ),
                          );
                        },
                        key: UniqueKey(),
                        title: 'Savings',
                        icon: Icons.account_balance_wallet,
                      ),
                      GridItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ComingSoonPage(featureName: "Loan"),
                            ),
                          );
                        },
                        key: UniqueKey(),
                        title: 'Loan',
                        icon: Icons.monetization_on,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: isLoadingPayment
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Financial Management',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Today's Expenditure: $expenditureAmount ৳",
                                  style: const TextStyle(
                                    color: Colors.pink,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Today's Deposit: $depositAmount ৳",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Column(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.pink,
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
                Container(
                  height: 215,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Scrollbar(
                      controller: _scrollController,
                      child: const TransactionHistory()),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          onTap: (int index) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _currentIndex = index;
                if (index == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRViewExample(),
                  ));
                } else if (index == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        UserProfilePage(userId: authState.userId),
                  ));
                }
              });
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'QR Code',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ));
  }

  void openAppDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
}
