import 'package:flutter/material.dart';

import '../routes.dart';

class BaseScreen extends StatefulWidget {
  final String title;
  final String profilePicUrl;
  final Widget body;
  final String name;
  final String email;
  final VoidCallback? onFabPressed;
  final IconData fabIcon;
  final int selectedIndex;
  final List<Widget>? appBarActions; // ✅ Custom AppBar actions

  const BaseScreen({
    Key? key,
    required this.title,
    required this.body,
    required this.profilePicUrl,
    required this.name,
    required this.email,
    this.onFabPressed,
    this.fabIcon = Icons.add,
    this.selectedIndex = 0,
    this.appBarActions, // ✅ Allow custom actions
  }) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    String route;
    switch (index) {
      case 0:
        route = AppRoutes.home;
        break;
      case 1:
        route = AppRoutes.listSales;
        break;
      case 2:
        route = AppRoutes.listInventory;
        break;
      case 3:
        route = AppRoutes.listProduct;
        break;
      case 4:
        route = AppRoutes.listCustomers;
        break;
      default:
        return;
    }

    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: widget.appBarActions, // ✅ Only custom actions are configurable
      ),
      drawer: _buildDrawer(context),
      body: widget.body,
      floatingActionButton: widget.onFabPressed != null
          ? FloatingActionButton(
              onPressed: widget.onFabPressed,
              backgroundColor: Colors.teal,
              child: Icon(widget.fabIcon, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.new_label_rounded, size: 30), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory, size: 30), label: "Inventory"),
          BottomNavigationBarItem(
              icon: Icon(Icons.next_week_rounded, size: 30), label: "Products"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30), label: "Customers"),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(widget.profilePicUrl),
            ),
            accountName: Text(
              widget.name,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            accountEmail: Text(widget.email),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    _onItemTapped(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profile"),
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    _onItemTapped(2);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
