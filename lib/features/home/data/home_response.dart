class HomeResponse {
  SalesResponse sales;
  InventoryResponse inventory;
  ProductResponse products;

  HomeResponse({
    required this.sales,
    required this.inventory,
    required this.products,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      sales: SalesResponse.fromJson(json['sales']),
      inventory: InventoryResponse.fromJson(json['inventory']),
      products: ProductResponse.fromJson(json['products']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sales': sales.toJson(),
      'inventory': inventory.toJson(),
      'products': products.toJson(),
    };
  }
}

class InventoryResponse {
  int inventoryAddedToday;
  int inventoryAddedThisMonth;
  int inventoryAddedTotal;

  InventoryResponse({
    required this.inventoryAddedToday,
    required this.inventoryAddedThisMonth,
    required this.inventoryAddedTotal,
  });

  factory InventoryResponse.fromJson(Map<String, dynamic> json) {
    return InventoryResponse(
      inventoryAddedToday: json['inventory_added_today'],
      inventoryAddedThisMonth: json['inventory_added_this_month'],
      inventoryAddedTotal: json['inventory_added_total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventoryAddedToday': inventoryAddedToday,
      'inventoryAddedThisMonth': inventoryAddedThisMonth,
      'inventoryAddedTotal': inventoryAddedTotal,
    };
  }
}

class ProductResponse {
  int productsAddedToday;
  int productsAddedThisMonth;
  int productsAddedTotal;

  ProductResponse({
    required this.productsAddedToday,
    required this.productsAddedThisMonth,
    required this.productsAddedTotal,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      productsAddedToday: json['products_added_today'],
      productsAddedThisMonth: json['products_added_this_month'],
      productsAddedTotal: json['products_added_total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productsAddedToday': productsAddedToday,
      'productsAddedThisMonth': productsAddedThisMonth,
      'productsAddedTotal': productsAddedTotal,
    };
  }
}

class SalesResponse {
  String salesToday;
  String salesThisMonth;
  String salesTotal;

  SalesResponse({
    required this.salesToday,
    required this.salesThisMonth,
    required this.salesTotal,
  });

  factory SalesResponse.fromJson(Map<String, dynamic> json) {
    return SalesResponse(
      salesToday: json['sales_today'].toString(),
      salesThisMonth: json['sales_this_month'].toString(),
      salesTotal: json['sales_total'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salesToday': salesToday,
      'salesThisMonth': salesThisMonth,
      'salesTotal': salesTotal,
    };
  }
}
