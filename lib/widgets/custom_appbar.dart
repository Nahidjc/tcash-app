import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
<<<<<<< HEAD
  final double appBarHeight = 50.0;
=======
  final double appBarHeight = 46.0;
>>>>>>> e003cb3f433c17d6fb7cd0552514e177fe57689b
  final Widget content;

  const CustomAppBar({required this.content});

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF3366FF),
            Color(0xFF00CCFF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: content,
      ),
    );
  }
}
