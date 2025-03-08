library new_inventory_library;

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/base_widget.dart';
import '../bloc/inventory_bloc.dart';

part 'new_inventory_screen.dart';

class NewInventoryController extends StatefulWidget {
  const NewInventoryController({super.key});

  @override
  State<NewInventoryController> createState() => NewInventoryControllerState();
}

class NewInventoryControllerState extends State<NewInventoryController> {
  String _scanBarcode = "";

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

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  void createInventory() {
    if (formKey.currentState!.validate()) {
      var name = nameController.text.toString();
      var quantity = quantityController.text.toString();
      var sku = skuController.text.toString();

      BlocProvider.of<InventoryBloc>(context)
          .add(AddInventory(sku: sku, quantity: double.tryParse(quantity)!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully!')),
      );
    }
    print("submit linked to controller");
  }

  @override
  Widget build(BuildContext context) => NewInventoryScreen(this);
}
