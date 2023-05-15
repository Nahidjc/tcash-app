import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/home_page.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/provider/todo_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider())
        ],
        child: MaterialApp(
          title: "tCash App",
          theme: ThemeData(
            primarySwatch: Colors.blue, // Set primary color
            fontFamily: 'Roboto', // Set default font family
            // Define other properties...
          ),
          debugShowCheckedModeBanner: false,
          home: const Scaffold(
              backgroundColor: Colors.white, body: Center(child: MyApp())),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
            body: Center(
      child: SpinKitSquareCircle(
        color: Colors.blue,
        size: 50.0,
      ),
    )));
  }
}
