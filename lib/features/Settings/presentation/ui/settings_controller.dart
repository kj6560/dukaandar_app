library settings_library;

import 'dart:convert';

import 'package:dukaandar/core/widgets/base_screen.dart';
import 'package:dukaandar/core/widgets/base_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/config.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../Auth/data/User.dart';

part '../ui/settings_screen.dart';

class SettingsController extends StatefulWidget {
  const SettingsController({super.key});

  @override
  State<SettingsController> createState() => SettingsControllerState();
}

class SettingsControllerState extends State<SettingsController> {
  String name = "";
  String email = "";

  void initAuthCred() async {
    String userJson = authBox.get(HiveKeys.userBox);
    User user = User.fromJson(jsonDecode(userJson));
    setState(() {
      name = user.name;
      email = user.email;
    });
  }

  @override
  void initState() {
    super.initState();
    initAuthCred();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(this);
  }
}
