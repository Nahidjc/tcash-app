import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nahid Hasan',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // TODO: Navigate to Home Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Statement'),
            onTap: () {
              // TODO: Navigate to Statement Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('Limit'),
            onTap: () {
              // TODO: Navigate to Limit Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Refer'),
            onTap: () {
              // TODO: Navigate to Refer Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Support'),
            onTap: () {
              // TODO: Navigate to Support Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // TODO: Perform Logout
            },
          ),
        ],
      ),
    );
  }
}
