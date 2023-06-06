import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/pages/cashout_page.dart';
import 'package:rnd_flutter_app/pages/components/amount_confirm.dart';
import 'package:rnd_flutter_app/pages/home_page.dart';
import 'package:rnd_flutter_app/pages/payment_page.dart';
import 'package:rnd_flutter_app/pages/send_money.dart';
import 'package:rnd_flutter_app/pages/signup_page.dart';
import 'package:rnd_flutter_app/pages/splash_screen.dart';
import 'package:rnd_flutter_app/pages/tcash_login.dart';

class AppRoutes {
  static const String splashscreen = '/splash_screen';
  static const String home = '/home_page';
  static const String login = '/login_page';
  static const String register = '/register_page';
  static const String sendmoney = '/send_money';
  static const String payment = '/payment_page';
  static const String cashout = '/cashout_page';
  static const String amountconfirm = '/amount_confirm';

  static Map<String, WidgetBuilder> routes = {
    splashscreen: (context) => const SplashScreen(),
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    register: (context) => const SignupPage(),
    sendmoney: (context) => const SendMoneyPage(),
    payment: (context) => const PaymentPage(),
    cashout: (context) => const CashoutPage(),
    amountconfirm: (context) => const AmountConfirm(),
  };
}
