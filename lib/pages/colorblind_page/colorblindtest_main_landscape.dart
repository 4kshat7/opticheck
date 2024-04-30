import 'dart:math';
import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/IshiharaPlate.dart';
import 'package:opticheck/utils/large_tap_box.dart';

class ColorblindtestMainLandscape extends StatefulWidget {
  ColorblindtestMainLandscape({Key? key}) : super(key: key);

  @override
  _ColorblindtestMainLandscapeState createState() =>
      _ColorblindtestMainLandscapeState();
}

class _ColorblindtestMainLandscapeState
    extends State<ColorblindtestMainLandscape> {
  //find the IshiharaList in global
  late List<IshiharaPlate> remainingPlates;
  late IshiharaPlate currentPlate;
  List<int> labels = [];
  Random random = Random();
  List<Color> labelColors = List.filled(4, colorBlindTestButtonColor);

  @override
  void initState() {
    super.initState();
    remainingPlates = List.from(plates);
    currentPlate = getNextPlate();
    generateLabels();
  }

  IshiharaPlate getNextPlate() {
    if (remainingPlates.isEmpty) {
      remainingPlates =
          List.from(plates); // Reset the list when all have been shown
    }
    int plateIndex = random.nextInt(remainingPlates.length);
    IshiharaPlate plate = remainingPlates[plateIndex];
    remainingPlates
        .removeAt(plateIndex); // Remove the plate from remaining ones
    return plate;
  }

  void generateLabels() {
    labels = List.generate(
        4,
        (_) =>
            random.nextInt(51)); // Generates four random labels from 0 to 100

    // Find a random position to place the correct label
    int correctLabelIndex = random.nextInt(4);

    // Assign the correct label to the randomly chosen position
    labels[correctLabelIndex] = currentPlate.correctLabel;

    // Ensure no duplicate of the correct label if not at the correct index
    for (int i = 0; i < labels.length; i++) {
      while (labels[i] == currentPlate.correctLabel && i != correctLabelIndex) {
        labels[i] = random
            .nextInt(51); // Re-generate if it's the same as the correct label
      }
    }

    labels.shuffle(random); // Optional shuffle to further randomize positions
  }

  void nextPlate(int selectedLabel, int index) {
    if (selectedLabel == currentPlate.correctLabel) {
      setState(() {
        labelColors[index] = Colors.green;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          currentPlate = getNextPlate();
          generateLabels();
          labelColors.fillRange(0, 4, colorBlindTestButtonColor);
        });
      });
    } else {
      setState(() {
        labelColors[index] = Colors.red;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          labelColors[index] = colorBlindTestButtonColor;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: calculateLogoSize(context) / 1.5,
            width: calculateLogoSize(context) / 1.5,
            child: Image.asset(
              currentPlate.imagePath,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                4,
                (index) => LargeTappableArea(
                      text: labels[index] != 0 ? '${labels[index]}' : 'nothing',
                      MainTextFontSize: calculateFontSize(context) * 2,
                      height: calculateBoxSize(context) / 2.5,
                      width: calculateBoxSize(context) / 2.5,
                      color: labelColors[index],
                      onTapAction: () => nextPlate(labels[index], index),
                    )),
          )
        ],
      ),
    );
  }
}
