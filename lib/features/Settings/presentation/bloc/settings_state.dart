part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class PrintersLoaded extends SettingsState {
  final List<BluetoothDevice> pairedPrinters;
  final BluetoothDevice? selectedPrinter;

  PrintersLoaded(this.pairedPrinters, this.selectedPrinter);
}
