part of sales_detail_library;

class SalesDetailScreen
    extends WidgetView<SalesDetailScreen, SalesDetailState> {
  SalesDetailScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Sales Detail",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      selectedIndex: 1,
      body: BlocConsumer<SalesBloc, SalesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingSalesDetail) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.teal),
                  SizedBox(height: 10),
                  Text("Loading...", style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else if (state is LoadSalesDetailsSuccess) {
            var details = jsonDecode(state.response.orderDetails);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildOrderDetail("Order ID", state.response.orderId),
                          _buildOrderDetail(
                              "Order Date", state.response.orderDate),
                          _buildOrderDetail("Total Order Value",
                              state.response.totalOrderValue),
                          _buildOrderDetail("Total Order Discount",
                              state.response.totalOrderDiscount),
                          _buildOrderDetail(
                              "Net Order Value", state.response.netOrderValue),
                          _buildOrderDetail(
                              "Net Amount", state.response.netTotal),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Order Items",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  showDetail(details),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.print),
                      label: Text("Print Invoice"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            );
          }
        },
      ),
    );
  }

  Widget _buildOrderDetail(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 15, color: Colors.black87)),
          Text(
            "$value",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget showDetail(dynamic details) {
    var decoded = jsonDecode(details);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: decoded.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = decoded[index];

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.shopping_bag, color: Colors.teal.shade700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item['product_name'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildItemDetail("Price", item['base_price']),
                const Divider(),
                _buildItemDetail("Quantity", item['quantity']),
                const Divider(),
                _buildItemDetail("Tax", item['tax']),
                const Divider(),
                _buildItemDetail("Discount", item['discount']),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Net: ₹${item['net_price']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemDetail(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade700)),
          Text("$value", style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
