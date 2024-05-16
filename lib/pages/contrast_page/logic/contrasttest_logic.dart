import 'dart:math';
import 'package:flutter/material.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/EyeCoverScreen.dart';
import 'package:opticheck/utils/landoltPlate.dart';
import 'package:provider/provider.dart';

class ContrastTestLogicController with ChangeNotifier {
  late ResultDataModel _resultDataModel;
  final String whicheye;
  late List<Landoltplate> remainingLandoltPlates;
  late Landoltplate currentPlate;
  // List<int> labels = [];
  Random random = Random();
  // List<Color> labelColors = List.filled(4, colorBlindTestButtonColor);
  int correctContrastPlatesCount = 0;
  int greyshade = 1000;
  bool whichIcon = false;
  double iconOpacity = 0.0;

  ContrastTestLogicController(BuildContext context, {required this.whicheye}) {
    remainingLandoltPlates = List.from(landoltPlates);
    currentPlate = getNextPlate(context);
    // generateLabels(context);
    _resultDataModel = Provider.of<ResultDataModel>(context, listen: false);
  }

  void nextPlate(context, int selectedLabel, int index) {
    // int cc = currentPlate.correctLabel;
    // print(
    //     'selectedLable: $selectedLabel and correctLanel: $cc and correctcount: $correctContrastPlatesCount ');
    if (selectedLabel == currentPlate.correctLabel) {
      whichIcon = true;
      iconOpacity = 1.0;
      correctContrastPlatesCount++;

      notifyListeners();

      Future.delayed(Duration(milliseconds: 300), () {
        iconOpacity = 0.0;
        currentPlate = getNextPlate(context);

        if (greyshade <= 100) {
          greyshade = greyshade - 50;
        } else
          greyshade = greyshade - 100;
        // generateLabels(context);
        // labelColors.fillRange(0, 4, colorBlindTestButtonColor);
        notifyListeners();
      });
    } else {
      whichIcon = false;
      iconOpacity = 1.0;

      if (whicheye == 'left') {
        _resultDataModel
            .updateLeftCorrectContrastPlatesCount(correctContrastPlatesCount);
      } else if (whicheye == 'right') {
        _resultDataModel
            .updateRightCorrectContrastPlatesCount(correctContrastPlatesCount);
      }

      notifyListeners();
      Future.delayed(Duration(milliseconds: 300), () {
        iconOpacity = 0.0;
        currentPlate = getNextPlate(context);
        if (greyshade <= 100) {
          greyshade = greyshade - 50;
        } else
          greyshade = greyshade - 100;
        // generateLabels(context);
        // labelColors.fillRange(0, 4, colorBlindTestButtonColor);
        // labelColors[index] = colorBlindTestButtonColor;

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

  Landoltplate getNextPlate(context) {
    if (remainingLandoltPlates.isEmpty) {
      // reset(context);
      remainingLandoltPlates = List.from(landoltPlates);
      currentPlate = getNextPlate(context);
      // reset(context);
      return currentPlate;
    }
    if (greyshade <= 50) {
      reset(context);
    }
    int plateIndex = random.nextInt(remainingLandoltPlates.length);
    Landoltplate landoltplate = remainingLandoltPlates[plateIndex];
    remainingLandoltPlates.removeAt(plateIndex);
    return landoltplate;
  }

  // void generateLabels(context) {
  //   if (remainingPlates.isEmpty) reset(context);
  //   labels = List.generate(4, (_) => random.nextInt(51));
  //   int correctLabelIndex = random.nextInt(4);
  //   labels[correctLabelIndex] = currentPlate.correctLabel;
  //   for (int i = 0; i < labels.length; i++) {
  //     while (labels[i] == currentPlate.correctLabel && i != correctLabelIndex) {
  //       labels[i] = random.nextInt(51);
  //     }
  //   }
  //   labels.shuffle(random);
  // }

  void reset(context) {
    if (whicheye == 'left') {
      _resultDataModel
          .updateLeftCorrectContrastPlatesCount(correctContrastPlatesCount);
    } else if (whicheye == 'right') {
      _resultDataModel
          .updateRightCorrectContrastPlatesCount(correctContrastPlatesCount);
    }

    correctContrastPlatesCount = 0;
    // remainingLandoltPlates = List.from(landoltPlates);
    // currentPlate = getNextPlate(context);
    // generateLabels(context);
    // labelColors.fillRange(0, 4, colorBlindTestButtonColor);
    if (whicheye == 'left') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Eyecoverscreen(
                  routeName: '/rightcontrasttestpage', whichEye: 'right')));
      ;
    } else {
      Navigator.pushNamed(context, '/contrastresultpage');
    }

    greyshade = 1000;
    notifyListeners();
  }
}
