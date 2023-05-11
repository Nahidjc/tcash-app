import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/provider/login_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // context.read<TodoProvider>().getTodo();
    context.read<AuthProvider>().token;
  }

 @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Text("Home"),

    );
  }
 
}
