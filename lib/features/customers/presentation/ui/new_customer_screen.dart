part of new_customer_library;

class NewCustomerScreen
    extends WidgetView<NewCustomerScreen, NewCustomerControllerState> {
  NewCustomerScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      title: "New Customer",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: BlocConsumer<CustomersBloc, CustomersState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              child: Column(
                children: [
                  Form(
                    key: controllerState.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: controllerState.customerNameController,
                            decoration: InputDecoration(
                              labelText: 'Enter Customer Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Customer name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller:
                                controllerState.customerAddressController,
                            decoration: InputDecoration(
                              labelText: 'Enter Customer Address',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter customer address';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller:
                                controllerState.customerPhoneNumberController,
                            decoration: InputDecoration(
                              labelText: 'Enter Customer Phone Number',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter customer phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Select Customer Active',
                              border: OutlineInputBorder(),
                            ),
                            value: controllerState.selectedValue,
                            items: controllerState.dropdownItems
                                .map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controllerState.updatePaymentMode(newValue);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 30,
                            child: ElevatedButton.icon(
                              onPressed: controllerState._takePicture,
                              icon: Icon(Icons.camera),
                              label: Text("Capture Image"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              //controllerState.createNewProduct();
                            },
                            child:
                                Text('Submit', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
