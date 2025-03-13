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
                  print(
                      "https://duk.shiwkesh.in/${state.response[index].customerPic}");
                  return Container(
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.red,
                                height: 150,
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    "https://duk.shiwkesh.in/${state.response[index].customerPic}"),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 160,
                                width:
                                    MediaQuery.of(context).size.width * 2 / 3 -
                                        10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${state.response[index].customerName}",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${state.response[index].customerAddress}",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${state.response[index].customerPhoneNumber}",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newCustomer);
      },
    );
  }
}
