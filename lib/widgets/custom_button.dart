import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget content;
  final VoidCallback onPressed;

  @override
  final Key? key;

  const CustomButton({
    required this.content,
    required this.onPressed,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: const LinearGradient(
          colors: [
            Colors.pinkAccent, Colors.pinkAccent
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(0, 2, 217, 255)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        child: content,
      ),
    );
  }
}
