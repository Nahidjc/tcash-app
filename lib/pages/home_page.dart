import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/app_drawer.dart';
import 'package:rnd_flutter_app/pages/qr_code_widget.dart';
import 'package:rnd_flutter_app/pages/transaction_history.dart';
import 'package:rnd_flutter_app/pages/user_profile.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

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
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 10),
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

  int _currentIndex = 0;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: AppDrawer(),
        ),
        appBar: AppBar(
          toolbarHeight: 70, // set the height of the AppBar
          backgroundColor: Colors.white,
          elevation: 0, // set elevation to 0 to remove shadow
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/113003788'),
              ),
              SizedBox(width: 8),
              Text(
                "Nahid Hasan",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle notification icon tap
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
            // IconButton(icon: const Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 8.0, bottom: 8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Current Balance',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 59, 163, 243),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: const Row(children: [
                        Expanded(
                            child: Text(
                          '৳ 100.00',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 20,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              GridView.count(
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
                      onTap: () {},
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
                ],
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
}
