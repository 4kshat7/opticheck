import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/large_glass_box.dart';
import 'package:provider/provider.dart';

class LandscapeColorblindResultPage extends StatefulWidget {
  const LandscapeColorblindResultPage({super.key});

  @override
  State<LandscapeColorblindResultPage> createState() =>
      _LandscapeColorblindResultPageState();
}

class _LandscapeColorblindResultPageState
    extends State<LandscapeColorblindResultPage> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultDataModel>(
      builder: (context, value, child) {
        if (value.correctPlatesCount != 0 && value.correctPlatesCount <= 13) {
          status = 'red';
        } else if (value.correctPlatesCount > 13 &&
            value.correctPlatesCount <= 17) {
          status = 'amber';
        } else if (value.correctPlatesCount > 17) {
          status = 'green';
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppBarColorUtil.getAppBarColor(status),
            title: Text(
              'Color-Blind Results',
              style: TextStyle(
                fontSize: calculateFontSize(context),
                fontFamily: 'Merriweather',
                fontWeight: globalFontWeight,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/selectionPage'));
                  },
                  child: SizedBox(
                    width: calculateIconSize(context) * 1.5,
                    height: calculateIconSize(context) * 1.5,
                    child: Image.asset(
                      testGlassesIcon,
                      color: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //   flex: 1,
              //   child: _buildEyeIconAndStatus(
              //       context, status, value.correctPlatesCount),
              // ),
              Positioned(
                top: 0, // Align to the top
                right: 0, // Align to the right
                child: Container(
                  height: calculateIconSize(context) * 2,
                  width: calculateIconSize(context) * 2,
                  child: Lottie.network(
                    'https://lottie.host/92145500-5b1c-4550-b665-ebf2b222159b/9jjwXSDcza.json',
                  ),
                ),
              ),
              _buildEyeIconAndStatus(context, status, value.correctPlatesCount),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildEyeIconAndStatus(
    BuildContext context, String status, int correctPlatesCount) {
  String statusText = '';
  String descText = '';
  Widget eyeIcon;

  switch (status) {
    case 'red':
      statusText = 'Category: Protanopia or Deuteranopia';
      descText =
          'You might have "Total red-green" color blindness. Protanopia is the inability to see the color red at all, while deuteranopiais is the inability to see the color green. Both conditions can impact tasks like reading traffic lights or identifying certain colors accurately. You are adviced to get this checked';
      eyeIcon = Image.asset(BadcolorBlindEyeIcon);
      break;
    case 'amber':
      statusText = 'Category: Protanomaly or Deuteranomaly';
      descText =
          'You might have "Partial red-green" color blindness. Affecting the perception of red and green hues. Protanomaly makes it difficult to see the color red properly. Deuteranomaly affects green perception.';
      eyeIcon = Image.asset(OkcolorBlindEyeIcon);
      break;
    case 'green':
      statusText = 'You have Trichromatic vision';
      descText =
          'You have "Normal color vision", you can perceive a full range of colors using all three cone cells in the eyes: red, green, and blue. This allows for accurate differentiation between various hues and shades across the visible spectrum.';
      eyeIcon = Image.asset(GoodcolorBlindEyeIcon);
      break;
    default:
      statusText = 'No Result';
      descText =
          'Take the Color-blind test to determine which category best describes your color vision.';
      eyeIcon = Image.asset(DefaultColorBlindIcon);
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: eyeIcon,
          ),
          Text(
            correctPlatesCount == 0
                ? ''
                : correctPlatesCount == plates.length - 1
                    ? 'Congratulations!!'
                    : 'You got $correctPlatesCount Correct',
            style: TextStyle(
                shadows: [
                  Shadow(
                    color: Colors.blue.shade900.withOpacity(1),
                    offset: Offset(0.5, 0.5),
                    blurRadius: 0.5,
                  ),
                ],
                fontSize: calculateFontSize(context) * 1.3,
                fontWeight: globalFontWeight,
                color: AppBarColorUtil.getAppBarColor(status)),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
      LargeGlassBox(
        MainText: statusText,
        SecondaryText: descText,
        MainTextFontSize: calculateFontSize(context) * 1.3,
        SecondaryTextFontSize: calculateFontSize(context),
        height: calculateBoxSize(context) * 1.5,
        width: calculateBoxSize(context) * 2.7,
        color: AppBarColorUtil.getAppBarColor(status),
        bottomRightImageData: 'lib/assets/images/opticheck_nobg.png',
      ),
    ],
  );
}
