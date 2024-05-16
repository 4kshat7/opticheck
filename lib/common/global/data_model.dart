import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ResultDataModel extends ChangeNotifier {
  int _correctPlatesCount = 0;

  int _correctLeftContrastPlatesCount = 0;
  int _correctRightContrastPlatesCount = 0;

  int _correctLeftAcuityPlateCount = 0;
  int _correctRightAcuityPlateCount = 0;

  double _Left_logMarvalue =
      2; // value is set to 2 , so that it does not disrupt acuity-result-page logic.
  double _Right_logMarvalue =
      2; // value is set to 2 , so that it does not disrupt acuity-result-page logic.

//bluetooth
  late BluetoothConnection? _connection = null; // Bluetooth connection field

// Getters
  int get correctPlatesCount => _correctPlatesCount;

  int get correctLeftContrastPlatesCount => _correctLeftContrastPlatesCount;
  int get correctRightContrastPlatesCount => _correctRightContrastPlatesCount;

  int get correctLeftAcuityPlateCount => _correctLeftAcuityPlateCount;
  int get correctRightAcuityPlateCount => _correctRightAcuityPlateCount;

  double get Left_logMarvalue => _Left_logMarvalue;
  double get Right_logMarvalue => _Right_logMarvalue;

  //bluetooth
  BluetoothConnection? get connection => _connection;

  void updateCorrectPlatesCount(int count) {
    _correctPlatesCount = count;
    notifyListeners();
  }

  void updateLeftCorrectContrastPlatesCount(int landoltcount) {
    _correctLeftContrastPlatesCount = landoltcount;
    notifyListeners();
  }

  void updateRightCorrectContrastPlatesCount(int landoltcount) {
    _correctRightContrastPlatesCount = landoltcount;
    notifyListeners();
  }

  void updateLeftCorrectAcuityPlatesCount(int acuitycount) {
    _correctLeftAcuityPlateCount = acuitycount;
    notifyListeners();
  }

  void updateRightCorrectAcuityPlatesCount(int acuitycount) {
    _correctRightAcuityPlateCount = acuitycount;
    notifyListeners();
  }

  void updateLeftNewLogValueReached(double logvalue) {
    _Left_logMarvalue = logvalue;
    notifyListeners();
  }

  void updateRightNewLogValueReached(double logvalue) {
    _Right_logMarvalue = logvalue;
    notifyListeners();
  }

  //bluetooth
  void updateBluetoothConnection(BluetoothConnection? connection) {
    _connection = connection;
    notifyListeners();
  }
}
