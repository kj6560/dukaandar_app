import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_bloc.dart';

class PrinterSelectionScreen extends StatelessWidget {
  const PrinterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Printer")),
      body: FutureBuilder<List<BluetoothDevice>>(
        future: BlueThermalPrinter.instance.getBondedDevices(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final devices = snapshot.data!;
          return ListView(
            children: devices.map((device) {
              return ListTile(
                title: Text(device.name ?? "Unknown"),
                subtitle: Text(device.address ?? ""),
                onTap: () {
                  context.read<SettingsBloc>().add(SelectPrinter(device));
                  Navigator.pop(context);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
