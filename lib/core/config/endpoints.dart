import 'base_url.dart';

class EndPoints {
  static const String appName = "Dukaandar";
  static const String login = '${baseUrl}/api/login';
  static const String logoutUrl = "$baseUrl/api/logout";

  static const String fetchKpi = '${baseUrl}/api/fetchKpi';

  static const String fetchProducts = '${baseUrl}/api/fetchProducts';
  static const String fetchProductUom = '${baseUrl}/api/fetchProductUoms';
  static const String addProduct = '${baseUrl}/api/addProduct';

  static const String fetchInventory = '${baseUrl}/api/fetchInventory';
  static const String updateInventory = '${baseUrl}/api/updateInventory';

  static const String fetchSales = '${baseUrl}/api/fetchOrders';
  static const String newSales = '${baseUrl}/api/updateOrder';

  static const String fetchCustomers = '${baseUrl}/api/fetchCustomers';
}
