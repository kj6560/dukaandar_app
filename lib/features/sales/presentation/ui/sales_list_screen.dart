part of sales_list_library;

class SalesListUi extends WidgetView<SalesListUi, SalesListControllerState> {
  SalesListUi(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      title: "Sales",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: BlocConsumer<SalesBloc, SalesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadSalesSuccess) {
              if (state.response.length > 0) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: state.response.length,
                    // Number of items in the list
                    itemBuilder: (context, index) {
                      SalesModel order = state.response[index];
                      return InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, AppRoutes.salesDetails,
                              arguments: {"sales_id": order.orderId});
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text("${order.orderId}")],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Amount: "),
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 14,
                                            ),
                                            Text("${order.netTotal}")
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${order.orderDate}')
                                          ],
                                        )
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
              } else {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("No Orders found"),
                      )
                    ],
                  ),
                );
              }
            } else if (state is LoadSalesFailure) {
              return Container();
            } else if (state is LoadingSalesList) {
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
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newSale);
      },
    );
  }
}
