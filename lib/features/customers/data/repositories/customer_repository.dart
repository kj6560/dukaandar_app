import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/config/endpoints.dart';

class CustomerRepositoryImpl {
  final Dio dio = Dio();

  CustomerRepositoryImpl();

  Future<Response?> fetchCustomers(int org_id, String token,
      {int customerId = 0}) async {
    try {
      var body = {'org_id': org_id};
      if (customerId != 0) {
        body['customer_id'] = customerId;
      }
      Response response = await dio.get(
        EndPoints.fetchCustomers,
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

  Future<Response?> newOrder(
      int org_id, int user_id, String payload, String token) async {
    try {
      var body = {
        'org_id': org_id,
        'order': jsonDecode(payload),
        'created_by': user_id
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
