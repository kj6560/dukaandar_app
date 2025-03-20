import 'package:dukaandar/core/local/hive_constants.dart';
import 'package:dukaandar/core/routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/config.dart';

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      if (authBox.get(HiveKeys.accessToken) != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            ),
            Center(child: Text("Initializing Plz wait..."))
          ],
        ),
      ),
    );
  }
}
