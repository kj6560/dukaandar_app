part of customers_list_library;

class CustomersListScreen
    extends WidgetView<CustomersListScreen, CustomersListControllerState> {
  CustomersListScreen(super.controllerState, {super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Customers",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      selectedIndex: 4,
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newCustomer);
      },
      body: BlocBuilder<CustomersBloc, CustomersState>(
        builder: (context, state) {
          if (state is LoadingCustomers) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.teal),
                  SizedBox(height: 8),
                  Text("Loading Customers"),
                ],
              ),
            );
          } else if (state is LoadCustomersSuccess) {
            List<Customer> allCustomers = state.response;
            List<Customer> filteredCustomers = List.from(allCustomers);

            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search by name or phone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          value = value.toLowerCase();
                          setState(() {
                            filteredCustomers = allCustomers.where((customer) {
                              return customer.customerName
                                      .toLowerCase()
                                      .contains(value) ||
                                  customer.customerPhoneNumber
                                      .toLowerCase()
                                      .contains(value);
                            }).toList();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: filteredCustomers.isEmpty
                          ? Center(child: Text("No Customers Found"))
                          : ListView.builder(
                              itemCount: filteredCustomers.length,
                              itemBuilder: (context, index) {
                                final customer = filteredCustomers[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.popAndPushNamed(
                                          context,
                                          AppRoutes.editCustomer,
                                          arguments: {
                                            "customer_id": customer.id,
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://duk.shiwkesh.in/${customer.customerPic}",
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 90,
                                                    height: 90,
                                                    color: Colors.grey[200],
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    customer.customerName,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    customer.customerAddress,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    customer
                                                        .customerPhoneNumber,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text("Customers Not Found"));
          }
        },
      ),
    );
  }
}
