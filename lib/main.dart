import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/provider/user_provider.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider())
    ], child: const MyApp()
        ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tCash App",
      theme: ThemeData(
        primarySwatch: Colors.pink, fontFamily: 'Roboto'
      ),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashscreen,
    );
  }
}
