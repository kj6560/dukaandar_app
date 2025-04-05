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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          margin: const EdgeInsets.all(12),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Labels Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(height: 8),
                                      Text(""),
                                      SizedBox(height: 6),
                                      Text("Today",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 12),
                                      Text("Monthly",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 12),
                                      Text("Total",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                // Products Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Products",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      const SizedBox(height: 12),
                                      Text(
                                          "${state.response.productsData.productsAddedToday}"),
                                      const SizedBox(height: 12),
                                      Text(
                                          "${state.response.productsData.productsAddedThisMonth}"),
                                      const SizedBox(height: 12),
                                      Text(
                                          "${state.response.productsData.productsAddedTotal}"),
                                    ],
                                  ),
                                ),
                                // Inventory Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Inventory",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      const SizedBox(height: 12),
                                      Text(
                                          "${state.response.inventoryData.inventoryAddedToday}"),
                                      const SizedBox(height: 12),
                                      Text(
                                          "${state.response.inventoryData.inventoryAddedThisMonth}"),
                                      const SizedBox(height: 12),
                                      Text(
                                          "${state.response.inventoryData.inventoryAddedTotal}"),
                                    ],
                                  ),
                                ),
                                // Sales Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Sales",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          const Icon(Icons.currency_rupee,
                                              size: 14),
                                          Text(
                                              "${state.response.salesData.salesToday}"),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          const Icon(Icons.currency_rupee,
                                              size: 14),
                                          Text(
                                              "${state.response.salesData.salesThisMonth}"),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          const Icon(Icons.currency_rupee,
                                              size: 14),
                                          Text(
                                              "${state.response.salesData.salesTotal}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is LoadFailure) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(state.error),
                      )
                    ],
                  ),
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
          selectedIndex: 0,
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
