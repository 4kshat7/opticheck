import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'dart:async'; // For Timer

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:provider/provider.dart';

class BluetoothConnectionProvider with ChangeNotifier {
  BluetoothConnection? _connection;
  StreamSubscription<Uint8List>? _subscription;
  bool _isConnecting = true;
  //sensor
  double _displayData = 0.00;
  String _dist = "0.00";
  double _prevDist = 0.00;

  BluetoothConnection? get connection => _connection;
  bool get isConnecting => _isConnecting;
  double get displayData => _displayData;
  String get dist => _dist;

  Future<void> connect(String address) async {
    try {
      _connection = await BluetoothConnection.toAddress(address);
      _isConnecting = false;
      notifyListeners();
    } catch (e) {
      _isConnecting = false;
      notifyListeners();
      print("Error connecting to device: $e");
    }
  }

  void disconnect() {
    _connection?.close();
    _connection = null;
    notifyListeners();
  }

  Future<void> startListening() async {
    _subscription = _connection?.input!.listen((Uint8List data) {
      double newDist = double.tryParse(utf8.decode(data)) ?? 0.00;
      _displayData = double.tryParse(ascii.decode(data)) ?? 0.00;
      if ((newDist - _prevDist).abs() >= 4.00) {
        _dist = utf8.decode(data);
        _prevDist = newDist;
        notifyListeners();
      }
    }, onDone: () {
      // Handle connection being closed
    });
  }
  // Optionally, set up a Timer if you need to perform actions periodically
  // _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) => _checkData());

  Future<void> sendMessage(String message) async {
    _connection?.output.add(Uint8List.fromList(utf8.encode(message)));
    await _connection?.output.allSent;
    if (message == 'O') {
      playerAudioFromPath('sensor_beep.mp3');
    }
    if (message == 'X') {
      playerAudioFromPath('click_shift.mp3');
    }

    if (kDebugMode) {
      print("Command sent: $message");
    }
  }
}
