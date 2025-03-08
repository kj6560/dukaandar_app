part of new_sale_library;

class NewSaleScreen extends WidgetView<NewSaleScreen, NewSaleControllerState> {
  NewSaleScreen(super.controllerState, {super.key});

  final List<String> items = List.generate(200, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      title: "Sales Detail",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: MultiBlocListener(
        listeners: [
          BlocListener<SalesBloc, SalesState>(
            listener: (context, salesState) {
              if (salesState is NewSalesFailure) {
                _showOrderDialog(context, 2);
              }
            },
          ),
          BlocListener<CustomersBloc, CustomersState>(
            listener: (context, customerState) {
              if (customerState is LoadCustomersSuccess &&
                  controllerState.selectedUser == null &&
                  customerState.response.isNotEmpty) {
                controllerState.selectedUser = customerState.response.first;
              }
            },
          ),
        ],
        child: BlocBuilder<SalesBloc, SalesState>(
          builder: (context, salesState) {
            if (salesState is NewSalesSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New Order Recorded!"),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Back'),
                    ),
                  ],
                ),
              );
            }

            return BlocBuilder<CustomersBloc, CustomersState>(
              builder: (context, customerState) {
                if (customerState is LoadingCustomers) {
                  return Center(child: CircularProgressIndicator());
                } else if (customerState is LoadCustomersFailure) {
                  return Center(child: Text("Failed to load customers"));
                } else if (customerState is LoadCustomersSuccess) {
                  return _buildSalesForm(context, customerState.response);
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSalesForm(BuildContext context, List<Customer> customers) {
    return Form(
      key: controllerState.formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 🔹 Barcode Scanner Button
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  String scannedSKU = await controllerState.scanBarcode();
                  if (scannedSKU.isNotEmpty) {
                    _showQuantityDialog(context, scannedSKU);
                  }
                },
                child: Text('Scan Barcode', style: TextStyle(fontSize: 18)),
              ),
            ),

            // 🔹 Orders List
            Expanded(
              child: ListView.builder(
                itemCount: controllerState.orders.length,
                itemBuilder: (context, index) {
                  NewOrder newOrder = controllerState.orders[index];
                  return Card(
                    child: ListTile(
                      title: Text('Sku: ${newOrder.sku}'),
                      subtitle: Text(
                          'Qty: ${newOrder.quantity} | Discount: ${newOrder.discount}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () =>
                            controllerState.removeOrderItem(newOrder),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔹 Payment Mode Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Payment Mode',
                border: OutlineInputBorder(),
              ),
              value: controllerState.selectedValue,
              items: controllerState.dropdownItems.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                controllerState.updatePaymentMode(newValue);
              },
            ),

            SizedBox(height: 10),

            // 🔹 Customer Dropdown
            DropdownButtonFormField<Customer>(
              decoration: InputDecoration(
                labelText: 'Select Customer',
                border: OutlineInputBorder(),
              ),
              value: controllerState.selectedUser,
              items: customers.map((Customer customer) {
                return DropdownMenuItem<Customer>(
                  value: customer,
                  child: customer.id != 0
                      ? Text(
                          "${customer.customerName}(${customer.customerPhoneNumber})")
                      : Text(customer.customerName),
                );
              }).toList(),
              onChanged: (Customer? selectedCustomer) {
                controllerState.selectedUser = selectedCustomer;
              },
            ),

            SizedBox(height: 10),

            // 🔹 Submit Button
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: 40,
              child: ElevatedButton(
                onPressed: () => controllerState.submitOrder(),
                child: Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showQuantityDialog(BuildContext context, String sku) async {
    // Default quantity

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        controllerState.resetDialog();
        return AlertDialog(
          title: Text("Fill the details"),
          content: SizedBox(
            height: 230,
            child: Column(
              children: [
                TextField(
                  controller: controllerState.qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Quantity",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controllerState.discountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Discount",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controllerState.taxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Tax",
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                double quantity =
                    double.tryParse(controllerState.qtyController.text) ??
                        1; // Validate input
                double discount =
                    double.parse(controllerState.discountController.text) ??
                        0.0;
                double tax = double.parse(controllerState.taxController.text);
                if (quantity > 0) {
                  NewOrder newOrder = NewOrder(
                      sku: sku,
                      quantity: quantity,
                      discount: discount,
                      tax: tax);
                  controllerState.updateOrder(newOrder);
                  print(controllerState.orders.length);
                  Navigator.of(context).pop(); // Close dialog
                }
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showOrderDialog(BuildContext context, int type) async {
    // Default quantity

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("New Order"),
          content: Container(
            child: Column(
              children: [
                Text(type == 1 ? "Order recorded!!" : "Failed To Record Order")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
