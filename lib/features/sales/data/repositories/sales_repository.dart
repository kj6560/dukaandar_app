import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/config/endpoints.dart';

class SaleRepositoryImpl {
  final Dio dio = Dio();

  SaleRepositoryImpl();

  Future<Response?> fetchOrder(int org_id, String token,
      {int orderId = 0}) async {
    try {
      var body = {'org_id': org_id};
      if (orderId != 0) {
        body['order_id'] = orderId;
      }
      Response response = await dio.get(
        EndPoints.fetchSales,
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

  Future<Response?> newOrder(int org_id, int user_id, String payload,
      int payment_method, int customer_id, String token) async {
    try {
      var body = {
        'org_id': org_id,
        'order': jsonDecode(payload),
        'created_by': user_id,
        'payment_mode': payment_method,
        'customer_id': customer_id
      };
      print(jsonEncode(body));
      Response response = await dio.post(
        EndPoints.newSales,
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
