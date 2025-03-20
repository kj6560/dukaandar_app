part of settings_library;

class SettingsScreen
    extends WidgetView<SettingsScreen, SettingsControllerState> {
  SettingsScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Settings",
      body: Container(),
      profilePicUrl: 'https://via.placeholder.com/150',
      name: controllerState.name,
      email: controllerState.email,
      selectedIndex: 2,
    );
  }
}
