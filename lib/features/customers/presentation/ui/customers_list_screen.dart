part of customers_list_library;

class CustomersListScreen
    extends WidgetView<CustomersListScreen, CustomersListControllerState> {
  CustomersListScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      title: "Customers",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: BlocConsumer<CustomersBloc, CustomersState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingCustomers) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    ),
                    Center(
                      child: Text("Loading Customers"),
                    )
                  ],
                ),
              );
            } else if (state is LoadCustomersSuccess) {
              return ListView.builder(
                itemCount: state.response.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: InkWell(
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.network(
                                    "https://duk.shiwkesh.in/${state.response[index].customerPic}",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(Icons.error,
                                            color: Colors.red),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 10),
                            // Add spacing between image and text
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // **Left Align**
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        "${state.response[index].customerName}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        "${state.response[index].customerAddress}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        "${state.response[index].customerPhoneNumber}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, AppRoutes.editCustomer, arguments: {
                          "customer_id": state.response[index].id
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("Customers Not found"),
                    )
                  ],
                ),
              );
            }
          }),
      selectedIndex: 4,
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newCustomer);
      },
    );
  }
}
