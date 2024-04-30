import 'package:flutter/material.dart';

class ResultDataModel extends ChangeNotifier {
  int _correctPlatesCount = 0;

  int get correctPlatesCount => _correctPlatesCount;

  void updateCorrectPlatesCount(int count) {
    _correctPlatesCount = count;
    notifyListeners();
  }
}
