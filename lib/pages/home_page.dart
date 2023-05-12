import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/transaction_history.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class GridItem extends StatelessWidget {
  // const GridItem({super.key});
  final String title;
  final IconData icon;
  @override
  // ignore: overridden_fields
  final Key? key;
  const GridItem({this.key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // context.read<TodoProvider>().getTodo();
    context.read<AuthProvider>().token;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
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
                        child: Row(children: const [
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
                        icon: Icons.send),
                    GridItem(
                        key: UniqueKey(),
                        title: 'Add Money',
                        icon: Icons.attach_money),
                    GridItem(
                        key: UniqueKey(),
                        title: 'Cash Out',
                        icon: Icons.monetization_on),
                    GridItem(
                        key: UniqueKey(),
                        title: 'Payment',
                        icon: Icons.payment),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
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
                          children: const [
                            Icon(Icons.arrow_forward_ios),
                          ],
                        )
                      ],
                  )),
              // Container(
              //   margin: const EdgeInsets.only(top: 10),
              //   padding: const EdgeInsets.all(20),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.1),
              //         spreadRadius: 1,
              //         blurRadius: 2,
              //         offset: const Offset(0, 1), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: const TransactionHistory(),
              // )
              Container(
                height: 200.0,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
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
                child: const Scrollbar(
                  child: TransactionHistory(),
                ),
              )
            ],
          ),
        ) 
        ));
  }
}
