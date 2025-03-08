library home_library;

import 'dart:convert';
import 'dart:io';

import 'package:dukaandar/core/config/config.dart';
import 'package:dukaandar/features/Auth/data/User.dart';
import 'package:dukaandar/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/local/hive_constants.dart';
import '../../../../core/routes.dart';
import '../../../../core/widgets/CircularCard.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/base_widget.dart';

part '../ui/home_screen.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => HomeControllerState();
}

class HomeControllerState extends State<HomeController> {
  String name = "";
  String email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAuthCred();
    BlocProvider.of<HomeBloc>(context).add(HomeLoad());
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
  Widget build(BuildContext context) => HomeScreen(this);
}
