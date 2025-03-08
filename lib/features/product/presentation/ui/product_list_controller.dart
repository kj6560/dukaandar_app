library product_list_library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../../core/routes.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/base_widget.dart';
import '../../../Auth/data/User.dart';
import '../../data/models/products_model.dart';
import '../bloc/product_bloc.dart';

part 'product_list_screen.dart';

class ProductListController extends StatefulWidget {
  const ProductListController({super.key});

  @override
  State<ProductListController> createState() => ProductListControllerState();
}

class ProductListControllerState extends State<ProductListController> {
  String name = "";
  String email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAuthCred();
    BlocProvider.of<ProductBloc>(context).add(LoadProductList());
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
  Widget build(BuildContext context) => ProductListUi(this);
}
