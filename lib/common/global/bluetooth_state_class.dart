import 'dart:async';
import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/foundation.dart';

class BluetoothManager {
  static final BluetoothManager _instance = BluetoothManager._internal();

  factory BluetoothManager() {
    return _instance;
  }

  BluetoothManager._internal();

  BluetoothConnection? connection;
  StreamController<double>? _streamController;

  Stream<double>? get distanceStream => _streamController?.stream;

  void initStream() {
    _streamController?.close();
    _streamController = StreamController<double>.broadcast();
    connection?.input?.listen((Uint8List data) {
      double newDist = double.tryParse(utf8.decode(data)) ?? 0.00;
      _streamController?.add(newDist);
    }).onDone(() {
      _streamController?.close();
    });
  }

  Future<bool> get isConnected async => connection?.isConnected ?? false;
}
