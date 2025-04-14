part of inventory_library;

class InventoryListUi
    extends WidgetView<InventoryListUi, InventoryListControllerState> {
  InventoryListUi(super.controllerState, {super.key});

  final TextEditingController _searchController = TextEditingController();
  List<InventoryModel> filteredInventory = [];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Inventory",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: BlocConsumer<InventoryBloc, InventoryState>(
        listener: (context, state) {
          if (state is LoadInventorySuccess) {
            filteredInventory = List.from(state.response);
            _searchController.clear();
            controllerState.changeSubscriptionStatus(true);
          }
          if (state is LoadInventoryFailure) {
            controllerState.changeSubscriptionStatus(false);
          }
        },
        builder: (context, state) {
          if (state is LoadingInventoryList) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.teal),
                  SizedBox(height: 8),
                  Text("Loading..."),
                ],
              ),
            );
          } else if (state is LoadInventorySuccess) {
            if (state.response.isNotEmpty) {
              return Column(
                children: [
                  // Search Field
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search inventory...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (query) {
                        query = query.toLowerCase();
                        if (query.isEmpty) {
                          filteredInventory = List.from(state.response);
                        } else {
                          filteredInventory = state.response.where((inventory) {
                            return inventory.product.name
                                .toLowerCase()
                                .contains(query);
                          }).toList();
                        }
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),

                  // Inventory List
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredInventory.length,
                      itemBuilder: (context, index) {
                        InventoryModel inventory = filteredInventory[index];
                        return InkWell(
                          onTap: () {
                            Navigator.popAndPushNamed(
                              context,
                              AppRoutes.inventoryDetails,
                              arguments: {"inventory_id": inventory.id},
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product name
                                    Row(
                                      children: [
                                        Icon(Icons.inventory_2_rounded,
                                            color: Colors.teal),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            inventory.product.name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    // Stock info
                                    Row(
                                      children: [
                                        Icon(Icons.check_circle_outline,
                                            color: Colors.green[700]),
                                        SizedBox(width: 8),
                                        Text(
                                          "In Stock: ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${inventory.balanceQuantity}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[800],
                                          ),
                                        ),
                                      ],
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
            } else {
              return Center(
                child: Text(
                  "No Inventory Data Found",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
          } else if (state is LoadInventoryFailure) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.teal),
            );
          }
        },
      ),
      selectedIndex: 2,
      onFabPressed: () {
        if (controllerState.hasActiveSubscription) {
          Navigator.pushNamed(context, AppRoutes.newInventory);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Subscription Required"),
                content: Text(
                    "You don't have an active subscription. Please contact Admin."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("OK", style: TextStyle(color: Colors.teal)),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
