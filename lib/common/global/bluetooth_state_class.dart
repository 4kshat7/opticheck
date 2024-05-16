import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothStateNotifier extends ChangeNotifier {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  BluetoothStateNotifier() {
    _initialize();
  }

  BluetoothState get bluetoothState => _bluetoothState;

  void _initialize() async {
    // Get initial state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    notifyListeners();

    // Listen for state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      _bluetoothState = state;
      notifyListeners();
    });
  }

  Future<void> requestEnable() async {
    final result = await FlutterBluetoothSerial.instance.requestEnable();
    if (result == true) {
      _bluetoothState = BluetoothState.STATE_ON;
    } else {
      _bluetoothState = BluetoothState.STATE_OFF;
    }
    notifyListeners();
  }
}
