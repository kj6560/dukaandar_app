import 'dart:convert';

import 'package:dukaandar/features/product/data/models/product_uom.dart';

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
  String createdAt;
  String updatedAt;
  ProductPrice? price; // ✅ Added ProductPrice model reference
  Uom? uom; // ✅ Added ProductUom model reference

  Product({
    required this.id,
    required this.orgId,
    required this.name,
    required this.sku,
    required this.productMrp,
    required this.isActive,
    required this.basePrice,
    this.createdAt = "",
    this.updatedAt = "",
    this.price, // ✅ New price field
    this.uom, // ✅ New UOM field
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      orgId: json['org_id'] ?? 0,
      name: json['name'],
      sku: json['sku'],
      productMrp: double.parse(json['product_mrp'].toString()),
      basePrice: json['price'] != null
          ? double.parse(json['price']['price'].toString())
          : 0.0, // ✅ Extract price
      isActive: json['is_active'],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      price: json['price'] != null
          ? ProductPrice.fromJson(json['price'])
          : null, // ✅ Parse price if available
      uom: json['uom'] != null
          ? Uom.fromJson(json['uom'])
          : null, // ✅ Parse UOM if available
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'name': name,
      'sku': sku,
      'product_mrp': productMrp,
      'base_price': basePrice,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'price': price?.toJson(), // ✅ Include price in JSON response
      'uom': uom?.toJson(), // ✅ Include UOM in JSON response
    };
  }
}

// ✅ Define ProductPrice model
class ProductPrice {
  int id;
  int productId;
  double price;
  int uomId;
  int isActive;
  String createdAt;
  String updatedAt;

  ProductPrice({
    required this.id,
    required this.productId,
    required this.price,
    required this.uomId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) {
    return ProductPrice(
      id: json['id'],
      productId: json['product_id'],
      price: double.parse(json['price'].toString()),
      uomId: json['uom_id'],
      isActive: json['is_active'],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'price': price,
      'uom_id': uomId,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

// ✅ Define ProductUom model
