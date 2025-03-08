part of home_library;

class HomeScreen extends WidgetView<HomeScreen, HomeControllerState> {
  HomeScreen(super.controllerState);

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          bool exitApp = await _onBackPressed(context);
          if (exitApp) {
            // Close the app
            Navigator.of(context).pop();
          }
        },
        child: BaseScreen(
          title: "Dukaandar",
          profilePicUrl: 'https://via.placeholder.com/150',
          name: controllerState.name,
          email: controllerState.email,
          body: BlocConsumer<HomeBloc, HomeState>(
            builder: (BuildContext context, state) {
              if (state is LoadingHome) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Loading",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is LoadSuccess) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                child: CircularCard(
                                  diameter: 70.0,
                                  color:
                                      Colors.teal, // Optional background color
                                  child: Icon(Icons.new_label_rounded,
                                      size: 50.0, color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.listSales);
                                },
                              ),
                              Text(
                                "Order",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                child: CircularCard(
                                  diameter: 70.0,
                                  color:
                                      Colors.teal, // Optional background color
                                  child: Icon(Icons.inventory,
                                      size: 50.0, color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.listInventory);
                                },
                              ),
                              Text(
                                "Inventory",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                child: CircularCard(
                                  diameter: 70.0,
                                  color:
                                      Colors.teal, // Optional background color
                                  child: Icon(Icons.next_week_rounded,
                                      size: 50.0, color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.listProduct);
                                },
                              ),
                              Text(
                                "Product",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                child: CircularCard(
                                  diameter: 70.0,
                                  color:
                                      Colors.teal, // Optional background color
                                  child: Icon(Icons.person,
                                      size: 50.0, color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.listCustomers);
                                },
                              ),
                              Text(
                                "Customers",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "SALES",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Today: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.currency_rupee,
                                      size: 14,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.sales.salesToday}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Monthly: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.currency_rupee,
                                      size: 14,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.sales.salesThisMonth}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1,
                                  child: Container(
                                    color: Colors.teal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Total: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.currency_rupee,
                                      size: 14,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.sales.salesTotal}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "INVENTORY",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Today: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.inventory.inventoryAddedToday}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Monthly: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.inventory.inventoryAddedThisMonth}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1,
                                  child: Container(
                                    color: Colors.teal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Total: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.inventory.inventoryAddedTotal}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "PRODUCTS",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Today: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.products.productsAddedToday}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Monthly: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.products.productsAddedThisMonth}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1,
                                  child: Container(
                                    color: Colors.teal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Total: ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.response.products.productsAddedTotal}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return Container(
                  child: Column(
                    children: [],
                  ),
                );
              }
            },
            listener: (BuildContext context, Object? state) {},
          ),
        ));
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    if (exitApp == true) {
      if (Platform.isAndroid) {
        SystemNavigator.pop(); // Closes the app on Android
      } else if (Platform.isIOS) {
        exit(0); // Force exit on iOS
      }
    }

    return Future.value(false);
  }
}
