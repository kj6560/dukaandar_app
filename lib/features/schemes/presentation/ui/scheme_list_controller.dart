library scheme_list_library;

import 'dart:convert';

import 'package:dukaandar/core/routes.dart';
import 'package:dukaandar/core/widgets/base_screen.dart';
import 'package:dukaandar/core/widgets/base_widget.dart';
import 'package:dukaandar/features/schemes/data/models/scheme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../Auth/data/User.dart';
import '../bloc/scheme_bloc.dart';

part '../ui/scheme_list_screen.dart';

class SchemeListController extends StatefulWidget {
  const SchemeListController({super.key});

  @override
  State<SchemeListController> createState() => SchemeListControllerState();
}

class SchemeListControllerState extends State<SchemeListController> {
  String name = "";
  String email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAuthCred();
    BlocProvider.of<SchemeBloc>(context).add(LoadSchemeList());
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
    return SchemeListScreen(this);
  }
}
