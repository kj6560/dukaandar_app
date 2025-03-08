library customers_list_library;

import 'package:flutter/material.dart';

import '../../../../core/widgets/base_widget.dart';

part '../ui/customers_list_screen.dart';

class CustomersListController extends StatefulWidget {
  const CustomersListController({super.key});

  @override
  State<CustomersListController> createState() =>
      CustomersListControllerState();
}

class CustomersListControllerState extends State<CustomersListController> {
  @override
  Widget build(BuildContext context) {
    return CustomersListScreen(this);
  }
}
