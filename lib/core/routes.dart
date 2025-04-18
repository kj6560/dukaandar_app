import 'package:dukaandar/features/Auth/presentation/ui/login_controller.dart';
import 'package:dukaandar/features/Organization/presentation/ui/create_organization_controller.dart';
import 'package:dukaandar/features/customers/presentation/ui/customers_list_controller.dart';
import 'package:dukaandar/features/home/presentation/ui/home_controller.dart';
import 'package:dukaandar/features/inventory/presentation/ui/inventory_detail_controller.dart';
import 'package:dukaandar/features/sales/presentation/ui/sales_detail_controller.dart';
import 'package:dukaandar/features/schemes/presentation/ui/scheme_details_controller.dart';
import 'package:dukaandar/features/schemes/presentation/ui/scheme_list_controller.dart';
import 'package:flutter/material.dart';

import '../features/Settings/presentation/ui/settings_controller.dart';
import '../features/customers/presentation/ui/edit_customer_controller.dart';
import '../features/customers/presentation/ui/new_customer_controller.dart';
import '../features/home/presentation/ui/entry.dart';
import '../features/inventory/presentation/ui/inventory_list_controller.dart';
import '../features/inventory/presentation/ui/new_inventory_controller.dart';
import '../features/product/presentation/ui/edit_product_controller.dart';
import '../features/product/presentation/ui/new_product_controller.dart';
import '../features/product/presentation/ui/product_detail_controller.dart';
import '../features/product/presentation/ui/product_list_controller.dart';
import '../features/sales/presentation/ui/new_sale_controller.dart';
import '../features/sales/presentation/ui/sales_list_controller.dart';
import '../features/schemes/presentation/ui/new_scheme_controller.dart';

class AppRoutes {
  static const String entry = '/entry';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String listInventory = '/list_inventory';
  static const String listProduct = '/list_product';
  static const String listSales = '/list_sales';
  static const String listCustomers = '/list_customers';
  static const String listSchemes = '/list_schemes';
  static const String newProduct = '/new_product';
  static const String editProduct = '/edit_product';
  static const String newSale = '/new_sale';
  static const String newInventory = '/new_Inventory';
  static const String newCustomer = '/new_customer';
  static const String editCustomer = '/edit_customer';
  static const String newScheme = '/new_scheme';
  static const String productDetails = '/product_details';
  static const String salesDetails = '/sales_details';
  static const String inventoryDetails = '/inventory_details';
  static const String schemeDetails = '/scheme_details';
  static const String appSettings = '/settings';
  static const String createOrg = '/createOrganization';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case entry:
        return MaterialPageRoute(builder: (_) => Entry());
      case login:
        return MaterialPageRoute(builder: (_) => LoginController());
      case home:
        return MaterialPageRoute(builder: (_) => HomeController());
      case listSales:
        return MaterialPageRoute(builder: (_) => SalesListController());
      case listCustomers:
        return MaterialPageRoute(builder: (_) => CustomersListController());
      case listInventory:
        return MaterialPageRoute(builder: (_) => InventoryListController());
      case listProduct:
        return MaterialPageRoute(builder: (_) => ProductListController());
      case listSchemes:
        return MaterialPageRoute(builder: (_) => SchemeListController());
      case appSettings:
        return MaterialPageRoute(builder: (_) => SettingsController());
      case newProduct:
        return MaterialPageRoute(builder: (_) => NewProductController());
      case editProduct:
        return MaterialPageRoute(
          builder: (context) {
            final args =
                settings.arguments as Map<String, dynamic>?; // Get arguments
            return EditProductController(); // Pass arguments if necessary
          },
          settings: settings, // Ensure arguments are attached to the route
        );
      case editCustomer:
        return MaterialPageRoute(
          builder: (context) {
            final args =
                settings.arguments as Map<String, dynamic>?; // Get arguments
            return EditCustomerController(); // Pass arguments if necessary
          },
          settings: settings, // Ensure arguments are attached to the route
        );
      case newSale:
        return MaterialPageRoute(builder: (_) => NewSaleController());
      case newCustomer:
        return MaterialPageRoute(builder: (_) => NewCustomerController());
      case newScheme:
        return MaterialPageRoute(builder: (_) => NewSchemeController());
      case newInventory:
        return MaterialPageRoute(builder: (_) => NewInventoryController());
      case salesDetails:
        return MaterialPageRoute(
          builder: (context) {
            final args =
                settings.arguments as Map<String, dynamic>?; // Get arguments
            return SalesDetailController(); // Pass arguments if necessary
          },
          settings: settings, // Ensure arguments are attached to the route
        );
      case inventoryDetails:
        return MaterialPageRoute(
          builder: (context) {
            final args =
                settings.arguments as Map<String, dynamic>?; // Get arguments
            return InventoryDetailController(); // Pass arguments if necessary
          },
          settings: settings, // Ensure arguments are attached to the route
        );
      case productDetails:
        return MaterialPageRoute(
          builder: (context) {
            final args =
                settings.arguments as Map<String, dynamic>?; // Get arguments
            return ProductDetailController(); // Pass arguments if necessary
          },
          settings: settings, // Ensure arguments are attached to the route
        );
      case schemeDetails:
        return MaterialPageRoute(
          builder: (context) {
            final args =
                settings.arguments as Map<String, dynamic>?; // Get arguments
            return SchemeDetailsController(); // Pass arguments if necessary
          },
          settings: settings, // Ensure arguments are attached to the route
        );
      case createOrg:
        return MaterialPageRoute(
            builder: (_) => CreateOrganizationController());
      default:
        return MaterialPageRoute(builder: (_) => LoginController());
    }
  }
}
