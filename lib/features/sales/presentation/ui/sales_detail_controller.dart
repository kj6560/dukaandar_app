library sales_detail_library;

import 'dart:convert';

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
}
