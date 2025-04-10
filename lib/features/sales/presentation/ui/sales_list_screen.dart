part of sales_list_library;

class SalesListUi extends WidgetView<SalesListUi, SalesListControllerState> {
  SalesListUi(super.controllerState, {super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Sales",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      selectedIndex: 1,
      onFabPressed: () {
        Navigator.pushNamed(context, AppRoutes.newSale);
      },
      body: BlocBuilder<SalesBloc, SalesState>(
        builder: (context, state) {
          if (state is LoadingSalesList) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.teal),
                  SizedBox(height: 8),
                  Text("Loading"),
                ],
              ),
            );
          } else if (state is LoadSalesFailure) {
            return Center(child: Text("Failed to load sales"));
          } else if (state is LoadSalesSuccess) {
            List<SalesModel> allSales = state.response;
            List<SalesModel> filteredSales = List.from(allSales);

            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search by Order ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          value = value.toLowerCase();
                          setState(() {
                            if (value.isEmpty) {
                              filteredSales = List.from(allSales);
                            } else {
                              filteredSales = allSales.where((sale) {
                                return sale.orderId
                                    .toString()
                                    .toLowerCase()
                                    .contains(value);
                              }).toList();
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: filteredSales.isEmpty
                          ? Center(child: Text("No Orders Found"))
                          : ListView.builder(
                              itemCount: filteredSales.length,
                              itemBuilder: (context, index) {
                                SalesModel order = filteredSales[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                      context,
                                      AppRoutes.salesDetails,
                                      arguments: {"sales_id": order.orderId},
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Order ID: ${order.orderId}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Amount: "),
                                                    Icon(Icons.currency_rupee,
                                                        size: 16),
                                                    Text("${order.netTotal}"),
                                                  ],
                                                ),
                                                Text(
                                                  '${order.orderDate}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
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
              },
            );
          } else {
            return Container(); // Fallback
          }
        },
      ),
    );
  }
}
