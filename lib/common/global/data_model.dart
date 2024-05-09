import 'package:flutter/material.dart';

class ResultDataModel extends ChangeNotifier {
  int _correctPlatesCount = 0;
  int _correctContrastPlatesCount = 0;

  int get correctPlatesCount => _correctPlatesCount;
  int get correctContrastPlatesCount => _correctContrastPlatesCount;

  void updateCorrectPlatesCount(int count) {
    _correctPlatesCount = count;
    notifyListeners();
  }

  void updateCorrectContrastPlatesCount(int landoltcount) {
    _correctContrastPlatesCount = landoltcount;
    notifyListeners();
  }
}
