import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/pages/cashout_page.dart';
import 'package:rnd_flutter_app/pages/components/amount_confirm.dart';
import 'package:rnd_flutter_app/pages/components/password_confirm.dart';
import 'package:rnd_flutter_app/pages/home_page.dart';
import 'package:rnd_flutter_app/pages/payment_page.dart';
import 'package:rnd_flutter_app/pages/send_money.dart';
import 'package:rnd_flutter_app/pages/signup_page.dart';
import 'package:rnd_flutter_app/pages/splash_screen.dart';
import 'package:rnd_flutter_app/pages/tcash_login.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';
import 'package:rnd_flutter_app/widgets/authenticate_checker.dart';

class AppRoutes {
  static const String splashscreen = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String sendmoney = '/sendmoney';
  static const String payment = '/payment';
  static const String cashout = '/cashout';
  static const String amountconfirm = '/amountconfirm';
  static const String passwordconfirm = '/passwordconfirm';

  static Map<String, WidgetBuilder> routes = {
    splashscreen: (context) => const SplashScreen(),
    home: (context) => AuthenticatedRoute(
          page: const HomePage(),
          isAuthenticated: Provider.of<AuthProvider>(context).isAuthenticated,
        ),
    login: (context) => const LoginPage(),
    register: (context) => const SignupPage(),
    sendmoney: (context) => AuthenticatedRoute(
          page: const SendMoneyPage(),
          isAuthenticated: Provider.of<AuthProvider>(context).isAuthenticated,
        ),
    payment: (context) => AuthenticatedRoute(
          page: const PaymentPage(),
          isAuthenticated: Provider.of<AuthProvider>(context).isAuthenticated,
        ),
    cashout: (context) => AuthenticatedRoute(
          page: const CashoutPage(),
          isAuthenticated: Provider.of<AuthProvider>(context).isAuthenticated,
        ),
    amountconfirm: (context) => AuthenticatedRoute(
          page: const AmountConfirm(),
          isAuthenticated: Provider.of<AuthProvider>(context).isAuthenticated,
        ),
    passwordconfirm: (context) => AuthenticatedRoute(
          page: const PasswordConfirm(),
          isAuthenticated: Provider.of<AuthProvider>(context).isAuthenticated,
        ),
  };
}
