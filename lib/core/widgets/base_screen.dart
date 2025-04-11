import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Auth/data/User.dart';
import '../../features/Auth/presentation/bloc/login_bloc.dart';
import '../config/config.dart';
import '../config/endpoints.dart';
import '../local/hive_constants.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late int _selectedIndex;
  String profilePic = "";
  User? user;

  @override
  void initState() {
    super.initState();
    initAuthCred();
    _selectedIndex = widget.selectedIndex;
  }

  void initAuthCred() async {
    String userJson = authBox.get(HiveKeys.userBox);
    User user = User.fromJson(jsonDecode(userJson));
    setState(() {
      profilePic = user!.profilePic!;
    });
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
      case 5:
        route = AppRoutes.appSettings;
        break;
      default:
        return;
    }

    // Close drawer before navigation
    Navigator.pop(context);

    // Use pushReplacementNamed to avoid stacking
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
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
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   selectedItemColor: Colors.teal,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home, size: 30), label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.new_label_rounded, size: 30), label: "Orders"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.inventory, size: 30), label: "Inventory"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.next_week_rounded, size: 30), label: "Products"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person, size: 30), label: "Customers"),
      //   ],
      // ),
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
                  leading: const Icon(Icons.new_label_rounded),
                  title: const Text("Orders"),
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.inventory),
                  title: const Text("Inventory"),
                  onTap: () {
                    _onItemTapped(2);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.next_week_rounded),
                  title: const Text("Products"),
                  onTap: () {
                    _onItemTapped(3);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Customers"),
                  onTap: () {
                    _onItemTapped(4);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    _onItemTapped(5);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () async {
                    bool loggedout = await logout();
                    if (loggedout) {
                      BlocProvider.of<LoginBloc>(context).add(LoginReset());
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.entry,
                        (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> logout() async {
    try {
      String userJson = authBox.get(HiveKeys.userBox);
      String token = authBox.get(HiveKeys.accessToken);
      User _user = User.fromJson(jsonDecode(userJson));

      var body = {'user_id': _user.id};
      Dio dio = Dio();

      Response response = await dio.get(
        EndPoints.logoutUrl,
        queryParameters: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data != null && response.data is Map<String, dynamic>) {
        await authBox.clear();
        return response.data['success'] == true;
      }

      return false;
    } catch (e, stacktrace) {
      print('Logout failed: $e');
      print(stacktrace);
      return false;
    }
  }
}
