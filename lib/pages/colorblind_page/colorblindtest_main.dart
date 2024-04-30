// import 'package:flutter/material.dart';
// import 'package:opticheck/common/global/global.dart';
// import 'package:opticheck/pages/colorblind_pages/slides/colorblind_page1.dart';
// import 'package:opticheck/pages/colorblind_pages/slides/colorblind_page2.dart';
// import 'package:opticheck/pages/colorblind_pages/slides/colorblind_page3.dart';
// import 'package:opticheck/pages/colorblind_pages/slides/colorblind_page4.dart';
// import 'package:opticheck/utils/large_tap_box.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class ColorblindtestMain extends StatelessWidget {
//   ColorblindtestMain({super.key});
//   final _controller = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// backgroundColor: globalBackgroundColor,
// body: Column(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     SizedBox(
//       height: 500,
//       // color: Colors.blue,
//       child: PageView(
//         controller: _controller,
//         physics: NeverScrollableScrollPhysics(),
//         children: [
//           ColorblindtestPage1(),
//           ColorblindtestPage2(),
//           ColorblindtestPage3(),
//           ColorblindtestPage4(),
//         ],
//       ),
//     ),
//     SmoothPageIndicator(
//       controller: _controller,
//       count: 4,
//       effect: ExpandingDotsEffect(
//         activeDotColor: primaryButtonBackgroundColor,
//         dotColor: globalSecondaryColor,
//         // spacing: 20
//       ),
//     ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: <Widget>[

//     LargeTappableArea(
//         text: '1',
//         MainTextFontSize: calculateFontSize(context) * 2,
//         height: calculateBoxSize(context) / 2.5,
//         width: calculateBoxSize(context) / 2.5,
//         onTapAction: () {
//           if (_controller.page! > 0) {
//             _controller.previousPage(
//                 duration: Duration(milliseconds: 300),
//                 curve: Curves.easeInOut);
//           }
//         }),
//     LargeTappableArea(
//         text: '2',
//         MainTextFontSize: calculateFontSize(context) * 2,
//         height: calculateBoxSize(context) / 2.5,
//         width: calculateBoxSize(context) / 2.5,
//         onTapAction: () {}),
//     LargeTappableArea(
//         text: '3',
//         MainTextFontSize: calculateFontSize(context) * 2,
//         height: calculateBoxSize(context) / 2.5,
//         width: calculateBoxSize(context) / 2.5,
//         onTapAction: () {}),
//     LargeTappableArea(
//         text: '4',
//         MainTextFontSize: calculateFontSize(context) * 2,
//         height: calculateBoxSize(context) / 2.5,
//         width: calculateBoxSize(context) / 2.5,
//         onTapAction: () {
//           if (_controller.page! < 3) {
//             _controller.nextPage(
//                 duration: Duration(milliseconds: 300),
//                 curve: Curves.easeInOut);
//           }
//         }),
//   ],
// )
//         ],
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/result_page/colorblind_result_page.dart';
import 'package:opticheck/utils/IshiharaPlate.dart';
import 'package:opticheck/utils/large_tap_box.dart';
import 'package:provider/provider.dart';

class ColorblindtestMain extends StatefulWidget {
  ColorblindtestMain({Key? key}) : super(key: key);

  @override
  _ColorblindtestMainState createState() => _ColorblindtestMainState();
}

class _ColorblindtestMainState extends State<ColorblindtestMain> {
  late ResultDataModel _resultDataModel;
  //find the IshiharaList in global
  late List<IshiharaPlate> remainingPlates;
  late IshiharaPlate currentPlate;
  List<int> labels = [];
  Random random = Random();
  List<Color> labelColors = List.filled(4, colorBlindTestButtonColor);

  int correctPlatesCount = 0;

  @override
  void initState() {
    super.initState();
    remainingPlates = List.from(plates);
    currentPlate = getNextPlate();
    generateLabels();
    _resultDataModel = Provider.of<ResultDataModel>(context, listen: false);
  }

  void nextPlate(int selectedLabel, int index) {
    if (selectedLabel == currentPlate.correctLabel) {
      setState(() {
        labelColors[index] = Colors.green;
        correctPlatesCount++;
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
        //push result if wrong to the colorblind result page
        _resultDataModel.updateCorrectPlatesCount(correctPlatesCount);
        Navigator.pushNamed(context, '/resultpage');

        setState(() {
          labelColors[index] = colorBlindTestButtonColor;
        });
      });
    }
  }

  IshiharaPlate getNextPlate() {
    if (remainingPlates.isEmpty) {
      // remainingPlates =List.from(plates); // Reset the list when all have been shown
      reset();
    }
    int plateIndex = random.nextInt(remainingPlates.length);
    IshiharaPlate plate = remainingPlates[plateIndex];
    remainingPlates
        .removeAt(plateIndex); // Remove the plate from remaining ones
    return plate;
  }

  void generateLabels() {
    if (remainingPlates.isEmpty) {
      reset();
    }
    labels = List.generate(4,
        (_) => random.nextInt(51)); // Generates four random labels from 0 to 50

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

  void reset() {
    //push the number of plates to the colorblind result page is all correct
    _resultDataModel.updateCorrectPlatesCount(correctPlatesCount);
    Navigator.pushNamed(context, '/resultpage');
    //

    correctPlatesCount = 0;
    remainingPlates = List.from(plates);
    currentPlate = getNextPlate();
    generateLabels();
    labelColors.fillRange(0, 4, colorBlindTestButtonColor);
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
            height: calculateLogoSize(context),
            width: calculateLogoSize(context),
            child: Image.asset(
              currentPlate.imagePath,
            ),
          ),
          // Text(remainingPlates.length.toString()),
          Text(
            'Choose what you see from the options below.',
            style: TextStyle(
              fontSize: calculateFontSize(context) / 1.2,
              fontWeight: globalFontWeight,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                4,
                (index) => LargeTappableArea(
                      text: labels[index] != 0 ? '${labels[index]}' : 'none',
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
