import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/pages/home_page.dart';
import 'package:rnd_flutter_app/pages/tcash_login.dart';
import 'package:rnd_flutter_app/pages/splash_screen.dart';

class AppRoutes {
  static const String splashscreen = '/splash_screen';
  static const String home = '/home_page';
  static const String login = '/login_page';

  static Map<String, WidgetBuilder> routes = {
    splashscreen: (context) => const SplashScreen(),
    home: (context) => const HomePage(),
    login: (context) => const LoginPage()
  };
}
