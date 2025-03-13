import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/config/endpoints.dart';

class ProductRepositoryImpl {
  Dio dio = Dio();

  ProductRepositoryImpl();

  Future<Response?> fetchProducts(int org_id, String token,
      {int id = 0}) async {
    try {
      var body = {'org_id': org_id};
      if (id != 0) {
        body['product_id'] = id;
      }
      Response response = await dio.get(
        EndPoints.fetchProducts,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(body),
      );
      return response;
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<Response?> fetchProductUom(int org_id, String token) async {
    try {
      var body = {'org_id': org_id};

      Response response = await dio.get(
        EndPoints.fetchProductUom,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(body),
      );
      return response;
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<Response?> addProducts(int org_id, String token, String name,
      String sku, double product_mrp, double base_price, int uom_id) async {
    try {
      var body = {
        'org_id': org_id,
        'name': name,
        'sku': sku,
        'product_mrp': product_mrp,
        'base_price': base_price,
        'uom_id': uom_id
      };
      print(body);
      Response response = await dio.post(
        EndPoints.addProduct,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(body),
      );
      return response;
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<Response?> generateBarcode(String token, String barcodeValue) async {
    try {
      var body = {'barcode_value': barcodeValue};
      print(body);
      Response response = await dio.get(
        EndPoints.generateBarcode,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(body),
      );
      return response;
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace);
    }
  }
}
