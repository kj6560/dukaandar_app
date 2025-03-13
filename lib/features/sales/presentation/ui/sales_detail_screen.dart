part of sales_detail_library;

class SalesDetailScreen
    extends WidgetView<SalesDetailScreen, SalesDetailState> {
  SalesDetailScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      title: "Sales Detail",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: BlocConsumer<SalesBloc, SalesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingSalesDetail) {
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
            } else if (state is LoadSalesDetailsSuccess) {
              var details = jsonDecode(state.response.orderDetails);

              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order Id",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text("${state.response.orderId}",
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Order Date",
                                          style: TextStyle(fontSize: 16)),
                                      Text("${state.response.orderDate}",
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Order Value",
                                          style: TextStyle(fontSize: 16)),
                                      Text("${state.response.totalOrderValue}",
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Order Discount",
                                          style: TextStyle(fontSize: 16)),
                                      Text(
                                          "${state.response.totalOrderDiscount}",
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Net Order Value",
                                          style: TextStyle(fontSize: 16)),
                                      Text("${state.response.netOrderValue}",
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Net Amount",
                                          style: TextStyle(fontSize: 16)),
                                      Text("${state.response.netTotal}",
                                          style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      showDetail(details),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Print Invoice"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

  showDetail(details) {
    var ddetails = jsonDecode(details);
    List<Widget> allWidgets = [];
    ddetails.forEach((item) {
      print(item['tax']);
      allWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Product Name"), Text(item['product_name'])],
      ));
      allWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Product Price"), Text("${item['base_price']}")],
      ));
      allWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Product Quantity"), Text("${item['quantity']}")],
      ));
      allWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Tax"), Text("${item['tax']}")],
      ));
      allWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Discount"), Text("${item['discount']}")],
      ));
      allWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Net Amount"), Text("${item['net_price']}")],
      ));
      allWidgets.add(Container(
        color: Colors.black,
        child: SizedBox(
          height: 1,
        ),
      ));
    });
    var detailView = Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: allWidgets,
          ),
        ),
      ),
    );
    return detailView;
  }
}
