import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/config.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../Auth/data/User.dart';
import '../../data/models/product_uom.dart';
import '../../data/models/products_model.dart';
import '../../data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepositoryImpl productRepositoryImpl = ProductRepositoryImpl();

  ProductBloc() : super(ProductInitial()) {
    on<LoadProductList>(_loadProduct);
    on<AddNewProduct>(_addNewProduct);
    on<LoadProductDetail>(_loadProductDetail);
    on<LoadProductUom>(_loadProductUom);
  }

  void _loadProduct(LoadProductList event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductList());
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      print('user org id: ${user.orgId}');
      final response =
          await productRepositoryImpl.fetchProducts(user.orgId!, token);
      if (response == null || response.data == null) {
        emit(LoadProductListFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final List<Product> products = productFromJson(jsonEncode(data));

      if (response.statusCode == 401) {
        emit(LoadProductListFailure("Login failed."));
        return;
      }
      emit(LoadProductSuccess(products));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoadProductListFailure("An error occurred."));
    }
    return;
  }

  void _addNewProduct(AddNewProduct event, Emitter<ProductState> emit) async {
    try {
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      int org_id = user.orgId;
      String name = event.name;
      String sku = event.sku;
      double product_mrp = event.price;
      double base_price = event.base_price;
      int uom_id = event.uom_id;
      final response = await productRepositoryImpl.addProducts(
          org_id, token, name, sku, product_mrp, base_price, uom_id);
      if (response == null || response.data == null) {
        emit(AddProductFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final Product product = Product.fromJson(data);

      if (response.statusCode == 401) {
        emit(AddProductFailure("Login failed."));
        return;
      }
      emit(AddProductSuccess(product));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(AddProductFailure("An error occurred."));
    }
    return;
  }

  void _loadProductDetail(
      LoadProductDetail event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductDetail());
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      int product_id = event.product_id;
      print('user org id: ${user.orgId}');
      final response = await productRepositoryImpl
          .fetchProducts(user.orgId!, token, id: product_id);
      if (response == null || response.data == null) {
        emit(LoadProductDetailFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final Product product = Product.fromJson(data);

      if (response.statusCode == 401) {
        emit(LoadProductDetailFailure("Login failed."));
        return;
      }
      emit(LoadProductDetailSuccess(product));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoadProductDetailFailure("An error occurred."));
    }
    return;
  }

  void _loadProductUom(LoadProductUom event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductUom());
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      print('user org id: ${user.orgId}');
      final response =
          await productRepositoryImpl.fetchProductUom(user.orgId!, token);
      if (response == null || response.data == null) {
        emit(LoadProductUomFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      Uom uom = Uom(
          id: 0,
          title: "select Unit of Measurement",
          slug: "select Unit of Measurement",
          isActive: 1);
      final List<Uom> productUoms = uomFromJson(jsonEncode(data));
      productUoms.insert(0, uom);
      if (response.statusCode == 401) {
        emit(LoadProductUomFailure("Login failed."));
        return;
      }
      emit(LoadProductUomSuccess(productUoms));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoadProductUomFailure("An error occurred."));
    }
    return;
  }
}
