import 'package:dukaandar/core/config/AppConstants.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final String profilePicUrl;
  final Widget body;
  final String name;
  final String email;
  final VoidCallback? onFabPressed; // Optional FAB action
  final IconData fabIcon; // Default FAB icon

  const BaseScreen({
    Key? key,
    required this.title,
    required this.body,
    required this.profilePicUrl,
    required this.name,
    required this.email,
    this.onFabPressed, // Default is null (optional)
    this.fabIcon = Icons.add, // Default icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: _buildDrawer(context),
      body: body,

      // Floating Action Button
      floatingActionButton: onFabPressed != null
          ? FloatingActionButton(
              onPressed: onFabPressed,
              backgroundColor: Colors.teal,
              child: Icon(fabIcon, color: Colors.white),
            )
          : null, // Hide FAB if no action is provided
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(profilePicUrl),
            ),
            accountName: Text(
              name,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            accountEmail: Text(email),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("About"),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/about',
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/settings',
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () {
                    Navigator.pop(context);
                    // Add logout logic here
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: [
                Text(
                  "©2025 All Rights Reserved",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              AppConstants.companyName,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
