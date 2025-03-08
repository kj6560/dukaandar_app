part of '../ui/inventory_detail_controller.dart';

class InventoryDetailScreen
    extends WidgetView<InventoryDetailScreen, InventoryDetailControllerState> {
  InventoryDetailScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
        title: "Inventory Detail",
        body: Container(
          child: BlocConsumer<InventoryBloc, InventoryState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is LoadingInventoryDetail) {
                return Container(
                  child: Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: Colors.teal,
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is LoadInventoryDetailFailure) {
                return Container(
                  child: Column(
                    children: [Center(child: Text("Failed to fetch Details"))],
                  ),
                );
              } else if (state is LoadInventoryDetailSuccess) {
                return Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          print("clicked on inventory");
                        },
                        child: Card(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      state.response.product.name,
                                      style: TextStyle(fontSize: 18),
                                    ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                          "Product Id: ${state.response.productId}",
                                          style: TextStyle(fontSize: 14)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        profilePicUrl: 'https://via.placeholder.com/150',
        name: controllerState.name,
        email: controllerState.email);
  }
}
