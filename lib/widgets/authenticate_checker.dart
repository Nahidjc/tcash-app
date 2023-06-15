import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/pages/tcash_login.dart';

class AuthenticatedRoute extends StatelessWidget {
  final Widget page;
  final bool isAuthenticated;

  const AuthenticatedRoute({
    required this.page,
    required this.isAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    if (isAuthenticated) {
      return page;
    } else {
      return const LoginPage();
    }
  }
}
