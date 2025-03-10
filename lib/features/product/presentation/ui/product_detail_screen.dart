part of product_detail_library;

class ProductDetailScreen
    extends WidgetView<ProductDetailScreen, ProductDetailControllerState> {
  ProductDetailScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
        title: "Product Detail",
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LoadingProductDetail) {
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
            } else if (state is LoadProductDetailSuccess) {
              return Container(
                height: 200,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Product Name: "),
                            Text("${state.response.name}")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Product Sku: "),
                            Text("${state.response.sku}")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Product MRP: "),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 12,
                                ),
                                Text("${state.response.productMrp}")
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Product Base Price: "),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 12,
                                ),
                                Text("${state.response.basePrice}")
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Product UOM: "),
                            Text("${state.response.uom!.slug}")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Product Active: "),
                            Text(
                                "${state.response.isActive == 1 ? 'Yes' : 'No'}")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                child: Column(
                  children: [
                    Center(
                      child: Text("Product Loading Failed"),
                    )
                  ],
                ),
              );
            }
          },
        ),
        profilePicUrl: 'https://via.placeholder.com/150',
        name: controllerState.name,
        email: controllerState.email);
  }
}
