import 'package:dukaandar/features/Settings/presentation/bloc/settings_bloc.dart';
import 'package:dukaandar/features/customers/presentation/bloc/customers_bloc.dart';
import 'package:dukaandar/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:dukaandar/features/sales/presentation/bloc/sales_bloc.dart';
import 'package:dukaandar/features/schemes/presentation/bloc/scheme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'core/local/hive_Services.dart';
import 'core/routes.dart';
import 'features/Auth/presentation/bloc/login_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  await HiveService.openBoxes();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return LoginBloc();
        }),
        BlocProvider(create: (context) {
          return HomeBloc();
        }),
        BlocProvider(create: (context) {
          return SalesBloc();
        }),
        BlocProvider(create: (context) {
          return InventoryBloc();
        }),
        BlocProvider(create: (context) {
          return ProductBloc();
        }),
        BlocProvider(create: (context) {
          return CustomersBloc();
        }),
        BlocProvider(create: (context) {
          return SchemeBloc();
        }),
        BlocProvider(create: (context) {
          return SettingsBloc();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dukaandar',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.entry,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
