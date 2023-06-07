import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/widgets/custom_appbar.dart';

class ComingSoonPage extends StatelessWidget {
  final String featureName;

  ComingSoonPage({required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          content: Text(
        "Coming Soon",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer,
              size: 64.0,
              color: Colors.pink.shade300,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'We are working on the $featureName feature.\nStay tuned!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.pink),
            ),
          ],
        ),
      ),
    );
  }
}
