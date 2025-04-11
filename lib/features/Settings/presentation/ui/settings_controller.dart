library settings_library;

import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:dukaandar/core/widgets/base_screen.dart';
import 'package:dukaandar/core/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/config/config.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../Auth/data/User.dart';
import '../bloc/settings_bloc.dart';
import 'PrinterSelectionScreen.dart';

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
    requestBluetoothPermissions();
  }

  Future<void> requestBluetoothPermissions() async {
    if (await Permission.bluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }

    if (await Permission.bluetoothScan.isDenied) {
      await Permission.bluetoothScan.request();
    }

    // Optional: Location for older Android versions
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
    context.read<SettingsBloc>().add(LoadPrinters());
  }

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(this);
  }
}
