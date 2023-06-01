import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/provider/todo_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => TodoProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider())
    ], child: const MyApp()
        // MaterialApp(
        //   home: const Scaffold(
        //       backgroundColor: Colors.white, body: Center(child: MyApp())),
        // )
        ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tCash App",
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set primary color
        fontFamily: 'Roboto', // Set default font family
        // Define other properties...
      ),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.register,
    );
  }
}
