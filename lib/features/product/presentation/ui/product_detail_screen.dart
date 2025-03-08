part of product_detail_library;

class ProductDetailScreen
    extends WidgetView<ProductDetailScreen, ProductDetailControllerState> {
  ProductDetailScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
        title: "Product Detail",
        body: Container(),
        profilePicUrl: 'https://via.placeholder.com/150',
        name: controllerState.name,
        email: controllerState.email);
  }
}
