import 'dart:convert';

List<NewOrder> newOrderFromJson(String str) =>
    List<NewOrder>.from(json.decode(str).map((x) => NewOrder.fromJson(x)));

String newOrderToJson(List<NewOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewOrder {
  String sku;
  double quantity;
  double discount;
  double tax;

  NewOrder(
      {required this.sku,
      required this.quantity,
      required this.discount,
      required this.tax});
  factory NewOrder.fromJson(Map<String, dynamic> json) {
    return NewOrder(
        sku: json['sku'],
        quantity: double.parse(json['quantity'].toString()),
        discount: json['discount'],
        tax: json['tax']);
  }

  Map<String, dynamic> toJson() {
    return {'sku': sku, 'quantity': quantity, 'discount': discount, 'tax': tax};
  }
}
