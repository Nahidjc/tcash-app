import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/home_page.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/provider/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: const MaterialApp(
          title: "Wallet App",
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: Colors.white, body: Center(child: MyApp())),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications,  color: Colors.white,),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
           IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu icon tap
            },
          ),
        ],
        title: Row(
          children: const <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/113003788'),
            ),
            SizedBox(width: 8),
            Text("Nahid Hasan"),
          ],
        ),
      ),
      body: const Center(
        child: HomePage(),
      ),
    );
  }
}
