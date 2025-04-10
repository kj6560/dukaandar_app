part of product_list_library;

class ProductListUi
    extends WidgetView<ProductListUi, ProductListControllerState> {
  ProductListUi(super.controllerState, {super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Products",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      selectedIndex: 3,
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newProduct);
      },
      appBarActions: [
        IconButton(
          icon: Icon(Icons.local_offer, color: Colors.white),
          onPressed: () {
            Navigator.popAndPushNamed(context, AppRoutes.listSchemes);
            print("schemes clicked");
          },
        ),
      ],
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is LoadingProductList) {
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
          } else if (state is LoadProductSuccess) {
            List<Product> allProducts = state.response;
            List<Product> filteredProducts = List.from(allProducts);

            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    // Search box
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search Products...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (query) {
                          query = query.toLowerCase();
                          setState(() {
                            if (query.isEmpty) {
                              filteredProducts = List.from(allProducts);
                            } else {
                              filteredProducts = allProducts.where((product) {
                                return product.name
                                        .toLowerCase()
                                        .contains(query) ||
                                    product.sku.toLowerCase().contains(query);
                              }).toList();
                            }
                          });
                        },
                      ),
                    ),

                    // Product list
                    Expanded(
                      child: filteredProducts.isEmpty
                          ? Center(child: Text("No products found"))
                          : ListView.builder(
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                Product product = filteredProducts[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                      context,
                                      AppRoutes.productDetails,
                                      arguments: {
                                        "product_id": product.id,
                                      },
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(Icons.qr_code,
                                                    size: 18,
                                                    color: Colors.grey[700]),
                                                SizedBox(width: 6),
                                                Text(
                                                  "SKU: ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    product.sku,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Icon(Icons.currency_rupee,
                                                    size: 18,
                                                    color: Colors.green[700]),
                                                SizedBox(width: 6),
                                                Text(
                                                  "${product.productMrp}",
                                                  style: TextStyle(
                                                    fontSize: 18,
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
              },
            );
          } else if (state is LoadProductListFailure) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.teal),
            );
          }
        },
      ),
    );
  }
}
