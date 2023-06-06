import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
<<<<<<< Updated upstream
    Future.delayed(const Duration(seconds: 3)).then(
<<<<<<< HEAD
        (value) => {Navigator.pushReplacementNamed(context, AppRoutes.login)});
=======
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        {Navigator.pushReplacementNamed(context, AppRoutes.sendmoney)});
>>>>>>> Stashed changes
=======
        (value) =>
        {Navigator.pushReplacementNamed(context, AppRoutes.home)});
>>>>>>> e003cb3f433c17d6fb7cd0552514e177fe57689b
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: SpinKitSquareCircle(
        color: Colors.blue,
        size: 50.0,
      ),
    ));
  }
}
