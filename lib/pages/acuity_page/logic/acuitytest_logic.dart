// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:opticheck/common/global/data_model.dart';
// import 'package:opticheck/common/global/global.dart';
// import 'package:opticheck/utils/AcuityPlate.dart';
// import 'package:provider/provider.dart';

// class AcuitytestLogicController with ChangeNotifier {
//   late ResultDataModel _resultDataModel;
//   late List<Acuityplate> remainingPlates;
//   late Acuityplate currentPlate;
//   List<String> labels = [];
//   Random random = Random();
//   List<Color> labelColors = List.filled(4, colorBlindTestButtonColor);
//   int correctAcuityPlatesCount = 0;

//   AcuitytestLogicController(context) {
//     remainingPlates = List.from(acuityPlates);
//     currentPlate = getNextPlate(context);
//     generateLabels(context);
//     _resultDataModel = Provider.of<ResultDataModel>(context, listen: false);
//   }

//   void nextPlate(context, String selectedLabel, int index) {
//     if (selectedLabel == currentPlate.letter) {
//       labelColors[index] = Colors.green;
//       correctAcuityPlatesCount++;
//       notifyListeners();

//       Future.delayed(Duration(milliseconds: 100), () {
//         currentPlate = getNextPlate(context);
//         generateLabels(context);
//         labelColors.fillRange(0, 4, colorBlindTestButtonColor);
//         notifyListeners();
//       });
//     } else {
//       labelColors[index] = Colors.red;
//       _resultDataModel.updateCorrectAcuityPlatesCount(correctAcuityPlatesCount);
//       notifyListeners();
//       Future.delayed(Duration(milliseconds: 100), () {
//         currentPlate = getNextPlate(context);
//         generateLabels(context);
//         labelColors.fillRange(0, 4, colorBlindTestButtonColor);
//         labelColors[index] = colorBlindTestButtonColor;

//         notifyListeners();
//       });
//     }
//   }

//   // void next() {
//   //   if (remainingPlates.isEmpty) {
//   //     reset();
//   //   } else {
//   //     currentPlate = getNextPlate();
//   //     generateLabels();
//   //     labelColors.fillRange(0, 4, colorBlindTestButtonColor);
//   //     notifyListeners();
//   //   }
//   // }

//   Acuityplate getNextPlate(BuildContext context) {
//     if (remainingPlates.isEmpty) {
//       reset(context);
//       return currentPlate; // Assuming you set `currentPlate` to something valid in `reset`
//     }
//     // Just return the first plate without removing it
//     return remainingPlates.first;
//   }

//   void usePlate(Acuityplate plate) {
//     remainingPlates.remove(plate);
//   }

// void generateLabels(BuildContext context) {
//   if (remainingPlates.isEmpty) reset(context);
//   labels = List.generate(4, (_) => ""); // Initialize with empty strings

//   List<Acuityplate> usedPlates = []; // List to hold used plates temporarily

//   // Ensure that the current plate is updated
//   currentPlate = getNextPlate(context);
//   usedPlates.add(currentPlate); // Add to used plates list

//   // Assign the correct letter to a random index
//   int correctLabelIndex = random.nextInt(4);
//   labels[correctLabelIndex] = currentPlate.letter;

//   // Fill other labels with random letters from the remaining plates
//   for (int i = 0; i < labels.length; i++) {
//     if (i == correctLabelIndex) continue;

//     Acuityplate randomPlate;
//     do {
//       randomPlate = getNextPlate(context);
//     } while (
//         usedPlates.contains(randomPlate)); // Ensure no repeats in one cycle

//     usedPlates.add(randomPlate);
//     labels[i] = randomPlate.letter;
//   }

//   // Remove all used plates from remainingPlates at once
//   remainingPlates.removeWhere((plate) => usedPlates.contains(plate));

//   // Shuffle the labels list
//   labels.shuffle(random);
// }

//   void reset(context) {
//     _resultDataModel.updateCorrectAcuityPlatesCount(correctAcuityPlatesCount);
//     correctAcuityPlatesCount = 0;
//     remainingPlates = List.from(acuityPlates);
//     currentPlate = getNextPlate(context);
//     generateLabels(context);
//     labelColors.fillRange(0, 4, colorBlindTestButtonColor);
//     Navigator.pushNamed(context, '/acuityresultpage');
//     notifyListeners();
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/AcuityPlate.dart';
import 'package:opticheck/utils/EyeCoverScreen.dart';
import 'package:provider/provider.dart';

class AcuitytestLogicController with ChangeNotifier {
  late ResultDataModel _resultDataModel;
  late String whicheye;
  List<Acuityplate> acuityPlates;
  List<String> labels = [];
  List<Color> labelColors =
      List.filled(4, colorBlindTestButtonColor); // Use a placeholder color
  int currentPlateIndex = 0;
  Acuityplate? currentPlate; // Optional to handle empty initial list
  int correctAcuityPlatesCount = 0;
  int _wrongAcuityPlateCount = 0;
  Random random = Random();

  AcuitytestLogicController(BuildContext context, this.acuityPlates,
      {required this.whicheye}) {
    _resultDataModel = Provider.of<ResultDataModel>(context, listen: false);
    if (acuityPlates.isNotEmpty) {
      currentPlate = acuityPlates.first;
      generateLabels(context);
    } else {
      // Handle the case where no acuity plates are provided
      print("Error: No acuity plates available.");
    }
  }

  void generateLabels(BuildContext context) {
    if (acuityPlates.isEmpty || currentPlate == null) {
      print("Error: No acuity plates available for label generation.");
      return;
    }

    labels = List.generate(4, (_) => ""); // Initialize with empty strings
    int correctLabelIndex =
        random.nextInt(4); // Determine where the correct label will be placed

    // Set the correct label at the randomly chosen index
    labels[correctLabelIndex] =
        currentPlate!.letter; // Safe access since currentPlate is checked

    // Collect a set of used letters to ensure no duplicates
    Set<String> usedLetters = {currentPlate!.letter};

    // Fill other labels with random letters from other plates, ensuring no duplicates in this cycle
    for (int i = 0; i < labels.length; i++) {
      if (labels[i].isEmpty) {
        // Only fill empty slots
        String randomLetter;
        do {
          randomLetter =
              acuityPlates[random.nextInt(acuityPlates.length)].letter;
        } while (usedLetters.contains(randomLetter)); // Ensure unique letters
        labels[i] = randomLetter;
        usedLetters.add(randomLetter); // Add to the set of used letters
      }
    }

    // Move to the next plate in preparation for the next cycle
    currentPlateIndex = (currentPlateIndex + 1) % acuityPlates.length;
    // currentPlate = acuityPlates[currentPlateIndex]; // Update the current plate
    labels.shuffle(random);
    notifyListeners();
  }

  void nextPlate(BuildContext context, String selectedLabel, int index) {
    if (currentPlateIndex == acuityPlates.length - 1) {
      reset(context);
    }
    if (selectedLabel == currentPlate!.letter) {
      // Safe access
      labelColors[index] = Colors.green;
      correctAcuityPlatesCount++;
      notifyListeners();
      Future.delayed(Duration(milliseconds: 100), () {
        currentPlate = acuityPlates[currentPlateIndex];
        generateLabels(context);
        labelColors.fillRange(0, 4, colorBlindTestButtonColor); // Reset colors
        notifyListeners();
      });
    } else {
      labelColors[index] = Colors.red;
      // _resultDataModel.updateNewLogValueReached(currentPlate!.logMARValue);
      _wrongAcuityPlateCount++;
      if (_wrongAcuityPlateCount > 2) {
        reset(context);
      }
      notifyListeners();
      Future.delayed(Duration(milliseconds: 100), () {
        currentPlate = acuityPlates[currentPlateIndex];
        generateLabels(context);
        // reset(context);

        labelColors.fillRange(0, 4, colorBlindTestButtonColor); // Reset colors
        // labelColors[index] = Colors.red; // Keep the incorrect choice red
        notifyListeners();
      });
    }
  }

  void reset(BuildContext context) {
    // _resultDataModel.updateNewLogValueReached(currentPlate!.logMARValue);
    // _resultDataModel.updateCorrectAcuityPlatesCount(correctAcuityPlatesCount);

    if (whicheye == 'left') {
      _resultDataModel
          .updateLeftCorrectAcuityPlatesCount(correctAcuityPlatesCount);
      _resultDataModel.updateLeftNewLogValueReached(
          acuityPlates[currentPlateIndex - 1].logMARValue);
    } else if (whicheye == 'right') {
      _resultDataModel
          .updateRightCorrectAcuityPlatesCount(correctAcuityPlatesCount);
      _resultDataModel.updateRightNewLogValueReached(
          acuityPlates[currentPlateIndex - 1].logMARValue);
    }

    if (acuityPlates.isEmpty) {
      print("Error: No acuity plates available to reset.");
      return;
    }
    if (whicheye == 'left') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Eyecoverscreen(
                  routeName: '/rightacuitytestpage', whichEye: 'right')));
      ;
    } else {
      Navigator.pushNamed(context, '/acuityresultpage');
    }

    currentPlateIndex = 0;
    currentPlate = acuityPlates[currentPlateIndex];
    correctAcuityPlatesCount = 0;
    _wrongAcuityPlateCount = 0;
    generateLabels(context);
    labelColors.fillRange(0, 4, colorBlindTestButtonColor);

    notifyListeners();
  }
}
