part of new_product_library;

class NewProductScreen
    extends WidgetView<NewProductScreen, NewProductControllerState> {
  NewProductScreen(super.controllerState, {super.key});

  final List<String> items = List.generate(200, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "New Product",
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is GenerateBarcodeSuccess) {
              controllerState.barcodeImageUrl =
                  state.barcodeUrl; // Store barcode image URL
            }
          },
          builder: (context, state) {
            if (state is LoadingProductUom) {
              return Center(
                  child: CircularProgressIndicator(color: Colors.teal));
            } else if (state is LoadProductUomFailure) {
              return Center(child: Text("Failed To Load UOMs"));
            } else if (state is LoadProductUomSuccess ||
                state is GenerateBarcodeSuccess) {
              if (controllerState.selectedUom == null &&
                  state is LoadProductUomSuccess &&
                  state.response.isNotEmpty) {
                controllerState.selectedUom = state.response.first;
              }
              return Form(
                key: controllerState.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerState.nameController,
                        decoration: InputDecoration(
                          labelText: 'Enter Product Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerState.priceController,
                        decoration: InputDecoration(
                          labelText: 'Enter Product Mrp',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product mrp';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerState.basePriceController,
                        decoration: InputDecoration(
                          labelText: 'Enter Product Base Price',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product base price';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          controllerState.scanBarcode();
                        },
                        child: Text('Scan Barcode',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerState.skuController,
                        decoration: InputDecoration(
                          labelText: 'Product Sku for/from barcode',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Product SKU is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          controllerState.generateBarcode();
                        },
                        child: Text('Generate Barcode',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    // Barcode Image Display + Download
                    if (state is GenerateBarcodeSuccess &&
                        controllerState.barcodeImageUrl != null)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              controllerState.barcodeImageUrl!,
                              width: 200,
                              height: 100,
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Text("Failed to load barcode image");
                              },
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await controllerState
                                    .downloadBarcodeImage(context);
                              },
                              icon: Icon(Icons.download),
                              label: Text("Download Barcode"),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<Uom>(
                          decoration: InputDecoration(
                            labelText: 'Select Unit of Measurement',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          value: controllerState.selectedUom,
                          items: state is LoadProductUomSuccess
                              ? state.response.map((Uom uom) {
                                  return DropdownMenuItem<Uom>(
                                    value: uom,
                                    child: uom.id != 0
                                        ? Text("${uom.slug} (${uom.title})")
                                        : Text("${uom.slug}"),
                                  );
                                }).toList()
                              : [],
                          onChanged: (Uom? newValue) {
                            if (newValue != null) {
                              controllerState.updateDropdownItems(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          controllerState.createNewProduct();
                        },
                        child: Text('Submit', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        profilePicUrl: 'https://via.placeholder.com/150',
        name: controllerState.name,
        email: controllerState.email);
  }
}
