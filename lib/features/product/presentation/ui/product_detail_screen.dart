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
            return SingleChildScrollView(
              child: Container(
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Name: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Expanded(
                                child: Text(
                              "${state.response.name}",
                              style: TextStyle(fontSize: 15),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Sku: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${state.response.sku}",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product MRP: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 12,
                                ),
                                Text(
                                  "${state.response.productMrp}",
                                  style: TextStyle(fontSize: 15),
                                )
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
                            Text(
                              "Product Base Price: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 12,
                                ),
                                Text(
                                  "${state.response.basePrice}",
                                  style: TextStyle(fontSize: 15),
                                )
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
                            Text(
                              "Product UOM: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${state.response.uom!.slug}",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Active: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${state.response.isActive == 1 ? 'Yes' : 'No'}",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
      fabIcon: Icons.edit,
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newProduct);
      },
      selectedIndex: 3,
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      appBarActions: [
        IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.popAndPushNamed(context, AppRoutes.editProduct,
                arguments: {"product_id": controllerState.product_id});
            print("schemes clicked");
          },
        ),
      ],
    );
  }
}
