library new_product_library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/base_widget.dart';
import '../../../Auth/data/User.dart';
import '../../data/models/product_uom.dart';
import '../bloc/product_bloc.dart';

part '../ui/new_product_screen.dart';

class NewProductController extends StatefulWidget {
  const NewProductController({super.key});

  @override
  State<NewProductController> createState() => NewProductControllerState();
}

class NewProductControllerState extends State<NewProductController> {
  String _scanBarcode = "";
  ProductUom? selectedUom;
  List<ProductUom> dropdownItems = [];

  String name = "";
  String email = "";

  void initAuthCred() async {
    String userJson = authBox.get(HiveKeys.userBox);
    User user = User.fromJson(jsonDecode(userJson));
    setState(() {
      name = user.name;
      email = user.email;
    });
  }

  void updateDropdownItems(items) {
    setState(() {
      selectedUom = items;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAuthCred();
    BlocProvider.of<ProductBloc>(context).add(LoadProductUom());
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController basePriceController = TextEditingController();

  @override
  Widget build(BuildContext context) => NewProductScreen(this);

  void createNewProduct() {
    if (formKey.currentState!.validate()) {
      var name = nameController.text.toString();
      var price = priceController.text.toString();
      var base_price = basePriceController.text.toString();
      var sku = skuController.text.toString();

      BlocProvider.of<ProductBloc>(context).add(
        AddNewProduct(
            sku: sku,
            name: name,
            price: double.tryParse(price)!,
            base_price: double.parse(base_price)!,
            uom_id: selectedUom!.id),
      );
      Navigator.popAndPushNamed(context, "/home");
    }
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      //Handle the scanned barcode result
      setState(() {
        _scanBarcode = barcodeScanRes;
        skuController.text = _scanBarcode;
      });
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
  }
}
