import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:dukaandar/core/local/hive_constants.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/config.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final BlueThermalPrinter printer = BlueThermalPrinter.instance;
  BluetoothDevice? selectedPrinter;
  List<BluetoothDevice> pairedPrinters = [];

  SettingsBloc() : super(SettingsInitial()) {
    on<LoadPrinters>(_onLoadPrinters);
    on<SelectPrinter>(_onSelectPrinter);
  }

  Future<void> _onLoadPrinters(LoadPrinters event, Emitter emit) async {
    final userSettings = await authBox.get(HiveKeys.settingsBox);
    final settings = jsonDecode(userSettings);
    final savedAddress = settings['printer_connected'];

    pairedPrinters = await printer.getBondedDevices();

    if (savedAddress != null) {
      try {
        selectedPrinter = pairedPrinters.firstWhere(
          (d) => d.address == savedAddress,
        );
      } catch (e) {
        selectedPrinter = null;
      }
    }

    emit(PrintersLoaded(pairedPrinters, selectedPrinter));
  }

  Future<void> _onSelectPrinter(SelectPrinter event, Emitter emit) async {
    selectedPrinter = event.device;

    // Get existing settings or initialize if null
    final userSettings = await authBox.get(HiveKeys.settingsBox);
    Map<String, dynamic> settings = {};

    if (userSettings != null) {
      try {
        settings = jsonDecode(userSettings);
      } catch (e) {
        // fallback to empty settings if corrupted
        settings = {};
      }
    }

    // Save selected printer address
    settings['printer_connected'] = selectedPrinter!.address;
    await authBox.put(HiveKeys.settingsBox, jsonEncode(settings));

    emit(PrintersLoaded(pairedPrinters, selectedPrinter));
  }
}
