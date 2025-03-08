import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  int orgId;
  String name;
  String sku;
  double productMrp;
  double basePrice;
  int isActive;
  String uom;
  String uomSlug;
  String createdAt;
  String updatedAt;

  Product({
    required this.id,
    required this.orgId,
    required this.name,
    required this.sku,
    required this.productMrp,
    required this.basePrice,
    required this.isActive,
    required this.uom,
    required this.uomSlug,
    this.createdAt = "",
    this.updatedAt = "",
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      orgId: json['org_id'] ?? 0, // Default to 0 if missing
      sku: json['sku'],
      productMrp: double.parse(json['product_mrp'].toString()),
      basePrice: double.parse(json['base_price'].toString()),
      isActive: json['is_active'],
      uom: json['uom'],
      uomSlug: json['uom_slug'],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'org_id': orgId,
      'sku': sku,
      'product_mrp': productMrp,
      'base_price': basePrice,
      'is_active': isActive,
      'uom': uom,
      'uom_slug': uomSlug,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
