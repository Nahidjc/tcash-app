import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/app_drawer.dart';
import 'package:rnd_flutter_app/pages/qr_code_widget.dart';
import 'package:rnd_flutter_app/pages/transaction_history.dart';
import 'package:rnd_flutter_app/pages/user_profile.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';
import 'package:rnd_flutter_app/widgets/coming_soon.dart';
import 'package:rnd_flutter_app/widgets/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class GridItem extends StatelessWidget {
  // const GridItem({super.key});
  final String title;
  final IconData icon;
  final Function()? onTap;
  @override
  // ignore: overridden_fields
  final Key? key;
  const GridItem(
      {this.key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
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
                size: 30,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.pink.shade400,
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    context.read<AuthProvider>().token;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: const AppDrawer(),
        ),
        appBar: MyAppBar(
          name: "Nahid Hasan",
          profilePicUrl: "https://avatars.githubusercontent.com/u/113003788",
          initialBalance: 500,
            openAppDrawer: openAppDrawer
        ),
        body: Padding(
            padding: const EdgeInsets.all(
                15.0), // Adjust the padding value as needed
            child: Column(
              children: [
                Container(
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
                      icon: Icons.send),
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
                          icon: Icons.payment,
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
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Financial Management',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your expense today ৳ 24',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.arrow_forward_ios),
                        ],
                      )
                    ],
                  )),
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
              ],
            )),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              if (index == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              } else if (index == 2) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserProfilePage(),
                ));
              }
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
