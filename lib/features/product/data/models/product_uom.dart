import 'dart:convert';

List<ProductUom> productUomFromJson(String str) =>
    List<ProductUom>.from(json.decode(str).map((x) => ProductUom.fromJson(x)));
String productUomToJson(ProductUom data) => json.encode(data.toJson());

class ProductUom {
  int id;
  String title;
  String slug;
  int isActive;

  ProductUom({
    required this.id,
    required this.title,
    required this.slug,
    required this.isActive,
  });

  factory ProductUom.fromJson(Map<String, dynamic> json) => ProductUom(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "is_active": isActive,
      };
}
