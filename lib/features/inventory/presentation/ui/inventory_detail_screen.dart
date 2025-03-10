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
                List<TransactionModel> tm = state.response.transactions;
                return Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, AppRoutes.productDetails, arguments: {
                            "product_id": state.response.productId
                          });
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Balance Quantity"),
                                    Text("${state.response.balanceQuantity}")
                                  ],
                                ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Transactions: "),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Transaction Type"),
                                    Text("Quantity"),
                                    Text("Transaction By")
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                  child: Container(
                                    color: Colors.teal,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                transaction(tm)
                              ],
                            ),
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

  transaction(tm) {
    List<Widget> tmWidgets = [];
    tm.forEach((item) {
      tmWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("${item.transactionType}"),
          Text("${item.quantity}"),
          Text("${item.user.name}")
        ],
      ));
    });
    return Column(
      children: tmWidgets,
    );
  }
}
