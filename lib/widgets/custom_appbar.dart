import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/routes/app_routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight = 56.0;
  final Widget content;

  const CustomAppBar({required this.content});

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.pink
      ),
      child: AppBar(
        
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: content,
        centerTitle: true,
      ),
    );
  }
}
