library sales_detail_library;

import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:dukaandar/core/widgets/base_screen.dart';
import 'package:dukaandar/core/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../Auth/data/User.dart';
import '../bloc/sales_bloc.dart';

part '../ui/sales_detail_screen.dart';

class SalesDetailController extends StatefulWidget {
  const SalesDetailController({super.key});

  @override
  State<SalesDetailController> createState() => SalesDetailState();
}

class SalesDetailState extends State<SalesDetailController> {
  String name = "";
  String email = "";
  String? salesId; // Store the received argument
  BluetoothDevice? selectedPrinter;

  @override
  void initState() {
    super.initState();
    _getArguments();
    initAuthCred();
  }

  void _getArguments() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      if (route == null) {
        print("❌ ModalRoute is NULL. Arguments not passed?");
        return;
      }

      final args = route.settings.arguments;
      if (args == null) {
        print("❌ Arguments are NULL. Check if Navigator is passing arguments.");
        return;
      }

      print("✅ Arguments found: $args");

      if (args is Map<String, dynamic> && args.containsKey("sales_id")) {
        String orderId = args["sales_id"].toString();
        print("✅ Order ID: $orderId"); // Debugging

        setState(() {
          salesId = orderId;
        });

        BlocProvider.of<SalesBloc>(context)
            .add(LoadSalesDetail(orderId: int.parse(orderId)));
      } else {
        print("❌ Arguments exist but 'sales_id' is missing.");
      }
    });
  }

  void initAuthCred() async {
    String userJson = authBox.get(HiveKeys.userBox);
    User user = User.fromJson(jsonDecode(userJson));
    setState(() {
      name = user.name;
      email = user.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SalesDetailScreen(this);
  }

  Future<void> printInvoice(String invoiceText) async {
    final printer = BlueThermalPrinter.instance;

    // Step 1: Load saved printer address
    final userSettings = await authBox.get(HiveKeys.settingsBox);
    if (userSettings == null) {
      print("❌ No printer settings found.");
      return;
    }

    late Map<String, dynamic> settings;
    try {
      settings = jsonDecode(userSettings);
    } catch (_) {
      print("❌ Failed to decode printer settings.");
      return;
    }

    final savedAddress = settings['printer_connected'];
    if (savedAddress == null) {
      print("❌ No printer saved.");
      return;
    }

    // Step 2: Get bonded (paired) devices
    final bondedDevices = await printer.getBondedDevices();

    BluetoothDevice? matchedPrinter;
    try {
      matchedPrinter = bondedDevices.firstWhere(
        (device) => device.address == savedAddress,
      );
    } catch (_) {
      matchedPrinter = null;
    }

    if (matchedPrinter == null) {
      print("❌ Saved printer not found among paired devices.");
      return;
    }

    // Step 3: Connect and Print
    try {
      final isConnected = await printer.isConnected ?? false;
      if (!isConnected) {
        await printer.connect(matchedPrinter);
        await Future.delayed(
            Duration(milliseconds: 300)); // optional stabilization
      }

      printer.printNewLine();
      printer.printCustom(invoiceText, 1, 0); // font size 1, align left
      printer.printNewLine();
      printer.paperCut();

      print("✅ Invoice printed to ${matchedPrinter.name}");
    } catch (e) {
      print("❌ Printing failed: $e");
    }
  }
}
