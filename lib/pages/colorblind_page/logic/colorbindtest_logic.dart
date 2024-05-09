import 'dart:math';
import 'package:flutter/material.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/IshiharaPlate.dart';
import 'package:provider/provider.dart';

class ColorblindTestLogicController with ChangeNotifier {
  late ResultDataModel _resultDataModel;
  late List<IshiharaPlate> remainingPlates;
  late IshiharaPlate currentPlate;
  List<int> labels = [];
  Random random = Random();
  List<Color> labelColors = List.filled(4, colorBlindTestButtonColor);
  int correctPlatesCount = 0;

  ColorblindTestLogicController(context) {
    remainingPlates = List.from(plates);
    currentPlate = getNextPlate(context);
    generateLabels(context);
    _resultDataModel = Provider.of<ResultDataModel>(context, listen: false);
  }

  void nextPlate(context, int selectedLabel, int index) {
    if (selectedLabel == currentPlate.correctLabel) {
      labelColors[index] = Colors.green;
      correctPlatesCount++;
      notifyListeners();

      Future.delayed(Duration(milliseconds: 100), () {
        currentPlate = getNextPlate(context);
        generateLabels(context);
        labelColors.fillRange(0, 4, colorBlindTestButtonColor);
        notifyListeners();
      });
    } else {
      labelColors[index] = Colors.red;
      _resultDataModel.updateCorrectPlatesCount(correctPlatesCount);
      notifyListeners();
      Future.delayed(Duration(milliseconds: 100), () {
        currentPlate = getNextPlate(context);
        generateLabels(context);
        labelColors.fillRange(0, 4, colorBlindTestButtonColor);
        labelColors[index] = colorBlindTestButtonColor;

        notifyListeners();
      });
    }
  }

  // void next() {
  //   if (remainingPlates.isEmpty) {
  //     reset();
  //   } else {
  //     currentPlate = getNextPlate();
  //     generateLabels();
  //     labelColors.fillRange(0, 4, colorBlindTestButtonColor);
  //     notifyListeners();
  //   }
  // }

  IshiharaPlate getNextPlate(context) {
    if (remainingPlates.isEmpty) {
      reset(context);
      return currentPlate;
    }
    int plateIndex = random.nextInt(remainingPlates.length);
    IshiharaPlate plate = remainingPlates[plateIndex];
    remainingPlates.removeAt(plateIndex);
    return plate;
  }

  void generateLabels(context) {
    if (remainingPlates.isEmpty) reset(context);
    labels = List.generate(4, (_) => random.nextInt(51));
    int correctLabelIndex = random.nextInt(4);
    labels[correctLabelIndex] = currentPlate.correctLabel;
    for (int i = 0; i < labels.length; i++) {
      while (labels[i] == currentPlate.correctLabel && i != correctLabelIndex) {
        labels[i] = random.nextInt(51);
      }
    }
    labels.shuffle(random);
  }

  void reset(context) {
    _resultDataModel.updateCorrectPlatesCount(correctPlatesCount);
    correctPlatesCount = 0;
    remainingPlates = List.from(plates);
    currentPlate = getNextPlate(context);
    generateLabels(context);
    labelColors.fillRange(0, 4, colorBlindTestButtonColor);
    Navigator.pushNamed(context, '/colorblindresultpage');
    notifyListeners();
  }
}
