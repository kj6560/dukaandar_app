part of product_list_library;

class ProductListUi
    extends WidgetView<ProductListUi, ProductListControllerState> {
  ProductListUi(super.controllerState, {super.key});

  final List<String> items = List.generate(200, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      title: "Products",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingProductList) {
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
            } else if (state is LoadProductSuccess) {
              print(state.response);
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount:
                      state.response.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    Product product = state.response[index];
                    return InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, AppRoutes.productDetails,
                            arguments: {"product_id": product.id});
                      },
                      child: Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          product.name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          product.sku,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Icon(
                                              Icons.currency_rupee,
                                              size: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              '${product.productMrp}',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          )
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
            } else if (state is LoadProductListFailure) {
              return Container(
                child: Center(
                  child: Text(state.error),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                ),
              );
            }
          }),
      selectedIndex: 3,
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newProduct);
      },
      appBarActions: [
        IconButton(
          icon: Icon(
            Icons.local_offer,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.popAndPushNamed(context, AppRoutes.listSchemes);
            print("schemes clicked");
          },
        ),
      ],
    );
    ;
  }
}
