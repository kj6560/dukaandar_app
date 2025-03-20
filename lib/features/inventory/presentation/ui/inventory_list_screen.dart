part of inventory_library;

class InventoryListUi
    extends WidgetView<InventoryListUi, InventoryListControllerState> {
  InventoryListUi(super.controllerState, {super.key});

  final List<String> items = List.generate(200, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      title: "Inventory",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: BlocConsumer<InventoryBloc, InventoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadInventorySuccess) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: state.response.length,
                  // Number of items in the list
                  itemBuilder: (context, index) {
                    InventoryModel inventory = state.response[index];
                    return InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, AppRoutes.inventoryDetails,
                            arguments: {"inventory_id": inventory.id});
                      },
                      child: Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text(inventory.product.name)],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text("In Stock: "),
                                          Text("${inventory.balanceQuantity}")
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is LoadInventoryFailure) {
              return Container();
            } else if (state is LoadingInventoryList) {
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
                      child: Text("Loading"),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
      selectedIndex: 2,
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newInventory);
      },
    );
  }
}
