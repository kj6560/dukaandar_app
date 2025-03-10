part of customers_list_library;

class CustomersListScreen
    extends WidgetView<CustomersListScreen, CustomersListControllerState> {
  CustomersListScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      title: "Customers",
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      body: BlocConsumer<CustomersBloc, CustomersState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container();
          }),
      onFabPressed: () {
        Navigator.popAndPushNamed(context, AppRoutes.newCustomer);
      },
    );
  }
}
