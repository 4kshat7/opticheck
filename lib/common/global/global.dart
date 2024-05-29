library globals;

import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:opticheck/utils/AcuityPlate.dart";
import "package:opticheck/utils/IshiharaPlate.dart";
import "package:opticheck/utils/landoltPlate.dart";

//images
const String globalLogoImage = 'lib/assets/images/opticheck.jpeg';
const String logoNoBgImage = 'lib/assets/images/opticheck_nobg.png';
const String logoIconImage = 'lib/assets/images/opticheck_icon.png';

const String bluetoothLogo = 'lib/assets/images/bluetooth.png';
const String motherboardLogo = 'lib/assets/images/motherboard.png';
const String sensorLogo = 'lib/assets/images/sensor.png';
const String sensorWave = 'lib/assets/images/sensor_wave.png';

const String analysisIcon = 'lib/assets/images/analysis.png';
const String analysisIconYellow = 'lib/assets/images/analysis_yellow.png';
const String testGlassesIcon = 'lib/assets/images/testing-glasses.png';

const String tickIcon = 'lib/assets/images/tick.png';
const String crossIcon = 'lib/assets/images/cross.png';
const String okStar = 'lib/assets/images/ok_star.png';

const String GoodcolorBlindEyeIcon =
    'lib/assets/images/good_colorblind_eye.png';
const String OkcolorBlindEyeIcon = 'lib/assets/images/ok_eye.png';
const String BadcolorBlindEyeIcon = 'lib/assets/images/bad_colorblind_eye.png';
const String DefaultColorBlindIcon = 'lib/assets/images/color-blind2.png';

const String Resultpage_bg = 'lib/assets/images/opticheck_result_bg.jpg';
const String Resultpage_bg2 = 'lib/assets/images/opticheck_result_bg2.jpg';

const String eyeGoodIcon = 'lib/assets/images/eye_good.png';
const String eyeBadIcon = 'lib/assets/images/eye_bad.png';
const String okstar = 'lib/assets/images/ok_star.png';
const String eyeAngle = 'lib/assets/images/eye-angle-white.png';

const String dropperIcon = 'lib/assets/images/dropper.png';
const String goodcontrast = 'lib/assets/images/good_contrast2.png';
const String okcontrast = 'lib/assets/images/ok_contrast.png';
const String badcontrast = 'lib/assets/images/bad_contrast.png';

//instructions images
const String colorBlindInstruction =
    'lib/assets/images/colorblindinstruction.png';
const String contrastinstruction = 'lib/assets/images/contrastinstruction.png';
const String acuityinstruction = 'lib/assets/images/acuitytestinstructions.png';

const String lefteyecover = 'lib/assets/images/eyecover_left.png';
const String righteyecover = 'lib/assets/images/eyecover_right.png';

//state eyes
const String badeyestate = 'lib/assets/images/bad_eye_state.png';
const String okeyestate = 'lib/assets/images/ok_eye_state.png';
const String goodeyestate = 'lib/assets/images/good_eye_state.png';

final player = AudioPlayer();

Future<void> playerAudioFromPath(String path) async {
  await player.play(AssetSource(path));
}

Size getScreenSize(BuildContext context) {
  MediaQueryData queryData = MediaQuery.of(context);
  return Size(queryData.size.width, queryData.size.height);
}

double calculateCurrentWidth(BuildContext context) {
  final currentWidth = getScreenSize(context).width;
  return currentWidth;
}

//main.dart
const Color globalBackgroundColor = Color.fromARGB(255, 243, 252, 253);
const Color globalPrimaryColor = Color.fromARGB(255, 11, 48, 72);
const Color globalSecondaryColor = Color.fromARGB(255, 155, 215, 216);
const Color globalTertiaryColor = Color.fromARGB(255, 248, 170, 19);

// Primary button
const Color primaryButtonBackgroundColor = Color.fromARGB(255, 3, 167, 166);
// Color.fromARGB(255, 71, 107, 224);
const String globalFontFamily = 'Poppins';
const FontWeight globalFontWeight = FontWeight.w700;

// AppBar height
double calculateAppBarHeight(BuildContext context) {
  double screenHeight = getScreenSize(context).height;
  return screenHeight * 0.10;
}

// Back icon
const double backIconSize = 28;
const Color backIconColor = globalPrimaryColor;

double calculateIconSize(BuildContext context) {
  Size screenSize = getScreenSize(context);
  double averageSize = (screenSize.height + screenSize.width) / 2;
  return averageSize * 0.05;
}

// Home page

const int logoSmallDuration = 500;
double calculateDesignHeight(BuildContext context) {
  double screenHeight = getScreenSize(context).height;
  return screenHeight * 0.15;
}

double calculateLogoSize(BuildContext context) {
  Size screenSize = getScreenSize(context);
  double averageSize = (screenSize.height + screenSize.width) / 2;
  return averageSize * 0.60;
}

double calculateFontSize(BuildContext context) {
  Size screenSize = getScreenSize(context);
  double averageSize = (screenSize.height + screenSize.width) / 2;
  // Base the calculation on a "standard" average screen size, which you might consider around 800 (combination of width and height)
  // Adjust the scale factor (here 0.02125) based on your testing across different devices to get a base size of 17 on an average device
  double scaleFactor = 0.030;
  return averageSize * scaleFactor;
}

double calculateBottomPosition(BuildContext context) {
  double screenHeight = getScreenSize(context).height;
  // Adjust the multiplier as needed to change the button's position based on screen size
  return screenHeight * 0.1; // 10% from the bottom of the screen
}

// Interactive Circle Util
double calculateInteractiveCircleSize(BuildContext context) {
  Size screenSize = getScreenSize(context);
  double averageSize = (screenSize.height + screenSize.width) / 2;
  return averageSize * 0.60;
}

//Bluetooth page

//Selection page

double calculateBoxSize(BuildContext context) {
  Size screenSize = getScreenSize(context);
  double averageSize = (screenSize.height + screenSize.width) / 2;
  return averageSize * 0.30;
}

const String VAinfo =
    'This will measure the sharpness of your vision by asking you to identify letters or symbols of different sizes on a chart from a dynamic distance.';
const String VCinfo =
    'This will assess your ability to distinguish between different shades of gray by displaying a series of images with varying levels of contrast between light and dark areas.';
const String CBinfo =
    'This will evaluate your ability to discern colors by presenting you with a series of plates containing colored dots, some of which form numbers or patterns that are visible only to those with normal color vision.';

// // COLORBLIND TEST PAGE

//ColorBlind Images
const String colorTest5 = 'lib/assets/images/5ColorTest.jpg';
const String colortest3 = 'lib/assets/images/3ColorTest.jpg';
const String colortest8 = 'lib/assets/images/8ColorTest.jpg';
const String colortest12 = 'lib/assets/images/12ColorTest.jpg';
const String colortest29 = 'lib/assets/images/29ColorTest.jpg';

const String colortest5_2 = 'lib/assets/images/5ColorTest2.jpg';
const String colortest15 = 'lib/assets/images/15ColorTest.jpg';
const String colortest74 = 'lib/assets/images/74ColorTest.jpg';
const String colortest6 = 'lib/assets/images/6ColorTest.jpg';
const String colortest45 = 'lib/assets/images/45ColorTest.jpg';
const String colortest7 = 'lib/assets/images/7ColorTest.jpg';
const String colortest16 = 'lib/assets/images/16ColorTest.jpg';
const String colortest73 = 'lib/assets/images/73ColorTest.jpg';
const String colortest26 = 'lib/assets/images/26ColorTest.jpg';
const String colortest42 = 'lib/assets/images/42ColorTest.jpg';

const String nullcolortest1 = 'lib/assets/images/nullColorTest.jpg';
const String nullcolortest2 = 'lib/assets/images/nullColorTest2.jpg';
const String nullcolortest3 = 'lib/assets/images/nullColorTest3.jpg';
const String nullcolortest4 = 'lib/assets/images/nullColorTest4.jpg';
const String nullcolortest5 = 'lib/assets/images/nullColorTest5.jpg';

final List<IshiharaPlate> plates = [
  IshiharaPlate(imagePath: colortest12, correctLabel: 12),
  IshiharaPlate(imagePath: colortest8, correctLabel: 8),
  IshiharaPlate(imagePath: colortest29, correctLabel: 29),
  IshiharaPlate(imagePath: colorTest5, correctLabel: 5),
  IshiharaPlate(imagePath: colortest3, correctLabel: 3),
  IshiharaPlate(imagePath: colortest5_2, correctLabel: 5),
  IshiharaPlate(imagePath: colortest15, correctLabel: 15),
  IshiharaPlate(imagePath: colortest74, correctLabel: 74),
  IshiharaPlate(imagePath: colortest6, correctLabel: 6),
  IshiharaPlate(imagePath: colortest45, correctLabel: 45),
  IshiharaPlate(imagePath: colortest7, correctLabel: 7),
  IshiharaPlate(imagePath: colortest16, correctLabel: 16),
  IshiharaPlate(imagePath: colortest73, correctLabel: 73),
  IshiharaPlate(imagePath: colortest26, correctLabel: 26),
  IshiharaPlate(imagePath: colortest42, correctLabel: 42),
  IshiharaPlate(imagePath: nullcolortest1, correctLabel: 0),
  IshiharaPlate(imagePath: nullcolortest2, correctLabel: 0),
  IshiharaPlate(imagePath: nullcolortest3, correctLabel: 0),
  IshiharaPlate(imagePath: nullcolortest4, correctLabel: 0),
  IshiharaPlate(imagePath: nullcolortest5, correctLabel: 0),
];

const Color colorBlindTestButtonColor = Colors.blueGrey;

// // CONTRAST IMAGES
const String landolt_U = 'lib/assets/images/Landolt_U.png';
const String landolt_UR = 'lib/assets/images/Landolt_UR.png';

const String landolt_R = 'lib/assets/images/Landolt_R.png';
const String landolt_BR = 'lib/assets/images/Landolt_BR.png';

const String landolt_B = 'lib/assets/images/Landolt_B.png';
const String landolt_BL = 'lib/assets/images/Landolt_BL.png';

const String landolt_L = 'lib/assets/images/Landolt_L.png';
const String landolt_UL = 'lib/assets/images/Landolt_UL.png';

final List<Landoltplate> landoltPlates = [
  Landoltplate(imagePath: landolt_U, correctLabel: 1),
  Landoltplate(imagePath: landolt_UR, correctLabel: 2),
  Landoltplate(imagePath: landolt_R, correctLabel: 3),
  Landoltplate(imagePath: landolt_BR, correctLabel: 4),
  Landoltplate(imagePath: landolt_B, correctLabel: 5),
  Landoltplate(imagePath: landolt_BL, correctLabel: 6),
  Landoltplate(imagePath: landolt_L, correctLabel: 7),
  Landoltplate(imagePath: landolt_UL, correctLabel: 8),
];

// // ACUITY PLATES
final List<Acuityplate> acuityPlates = [
  Acuityplate(letter: 'H', logMARValue: 1.0, fontSizeMm: 69.7),
  Acuityplate(letter: 'V', logMARValue: 1.0, fontSizeMm: 69.7),
  Acuityplate(letter: 'Z', logMARValue: 1.0, fontSizeMm: 69.7),
  Acuityplate(letter: 'D', logMARValue: 1.0, fontSizeMm: 69.7),
  Acuityplate(letter: 'S', logMARValue: 1.0, fontSizeMm: 69.7),
  Acuityplate(letter: 'N', logMARValue: 0.9, fontSizeMm: 55.3),
  Acuityplate(letter: 'C', logMARValue: 0.9, fontSizeMm: 55.3),
  Acuityplate(letter: 'V', logMARValue: 0.9, fontSizeMm: 55.3),
  Acuityplate(letter: 'K', logMARValue: 0.9, fontSizeMm: 55.3),
  Acuityplate(letter: 'D', logMARValue: 0.9, fontSizeMm: 55.3),
  Acuityplate(letter: 'C', logMARValue: 0.8, fontSizeMm: 43.9),
  Acuityplate(letter: 'Z', logMARValue: 0.8, fontSizeMm: 43.9),
  Acuityplate(letter: 'S', logMARValue: 0.8, fontSizeMm: 43.9),
  Acuityplate(letter: 'H', logMARValue: 0.8, fontSizeMm: 43.9),
  Acuityplate(letter: 'N', logMARValue: 0.8, fontSizeMm: 43.9),
  Acuityplate(letter: 'O', logMARValue: 0.7, fontSizeMm: 34.9),
  Acuityplate(letter: 'N', logMARValue: 0.7, fontSizeMm: 34.9),
  Acuityplate(letter: 'V', logMARValue: 0.7, fontSizeMm: 34.9),
  Acuityplate(letter: 'S', logMARValue: 0.7, fontSizeMm: 34.9),
  Acuityplate(letter: 'R', logMARValue: 0.7, fontSizeMm: 34.9),
  Acuityplate(letter: 'K', logMARValue: 0.6, fontSizeMm: 27.7),
  Acuityplate(letter: 'D', logMARValue: 0.6, fontSizeMm: 27.7),
  Acuityplate(letter: 'N', logMARValue: 0.6, fontSizeMm: 27.7),
  Acuityplate(letter: 'R', logMARValue: 0.6, fontSizeMm: 27.7),
  Acuityplate(letter: 'O', logMARValue: 0.6, fontSizeMm: 27.7),
  Acuityplate(letter: 'Z', logMARValue: 0.5, fontSizeMm: 22.0),
  Acuityplate(letter: 'K', logMARValue: 0.5, fontSizeMm: 22.0),
  Acuityplate(letter: 'C', logMARValue: 0.5, fontSizeMm: 22.0),
  Acuityplate(letter: 'S', logMARValue: 0.5, fontSizeMm: 22.0),
  Acuityplate(letter: 'V', logMARValue: 0.5, fontSizeMm: 22.0),
  Acuityplate(letter: 'D', logMARValue: 0.4, fontSizeMm: 17.5),
  Acuityplate(letter: 'V', logMARValue: 0.4, fontSizeMm: 17.5),
  Acuityplate(letter: 'O', logMARValue: 0.4, fontSizeMm: 17.5),
  Acuityplate(letter: 'H', logMARValue: 0.4, fontSizeMm: 17.5),
  Acuityplate(letter: 'C', logMARValue: 0.4, fontSizeMm: 17.5),
  Acuityplate(letter: 'O', logMARValue: 0.3, fontSizeMm: 13.9),
  Acuityplate(letter: 'H', logMARValue: 0.3, fontSizeMm: 13.9),
  Acuityplate(letter: 'V', logMARValue: 0.3, fontSizeMm: 13.9),
  Acuityplate(letter: 'C', logMARValue: 0.3, fontSizeMm: 13.9),
  Acuityplate(letter: 'K', logMARValue: 0.3, fontSizeMm: 13.9),
  Acuityplate(letter: 'H', logMARValue: 0.2, fontSizeMm: 11.0),
  Acuityplate(letter: 'Z', logMARValue: 0.2, fontSizeMm: 11.0),
  Acuityplate(letter: 'C', logMARValue: 0.2, fontSizeMm: 11.0),
  Acuityplate(letter: 'K', logMARValue: 0.2, fontSizeMm: 11.0),
  Acuityplate(letter: 'O', logMARValue: 0.2, fontSizeMm: 11.0),
  Acuityplate(letter: 'N', logMARValue: 0.1, fontSizeMm: 8.7),
  Acuityplate(letter: 'C', logMARValue: 0.1, fontSizeMm: 8.7),
  Acuityplate(letter: 'K', logMARValue: 0.1, fontSizeMm: 8.7),
  Acuityplate(letter: 'H', logMARValue: 0.1, fontSizeMm: 8.7),
  Acuityplate(letter: 'D', logMARValue: 0.1, fontSizeMm: 8.7),
  Acuityplate(letter: 'Z', logMARValue: 0.0, fontSizeMm: 6.9),
  Acuityplate(letter: 'H', logMARValue: 0.0, fontSizeMm: 6.9),
  Acuityplate(letter: 'C', logMARValue: 0.0, fontSizeMm: 6.9),
  Acuityplate(letter: 'S', logMARValue: 0.0, fontSizeMm: 6.9),
  Acuityplate(letter: 'R', logMARValue: 0.0, fontSizeMm: 6.9),
  Acuityplate(letter: 'S', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'Z', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'R', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'D', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'N', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'S', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'Z', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'R', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'D', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'N', logMARValue: -0.1, fontSizeMm: 5.5),
  Acuityplate(letter: 'R', logMARValue: -0.3, fontSizeMm: 3.5),
  Acuityplate(letter: 'D', logMARValue: -0.3, fontSizeMm: 3.5),
  Acuityplate(letter: 'O', logMARValue: -0.3, fontSizeMm: 3.5),
  Acuityplate(letter: 'S', logMARValue: -0.3, fontSizeMm: 3.5),
  Acuityplate(letter: 'N', logMARValue: -0.3, fontSizeMm: 3.5),
];

// // RESULT PAGE
class AppBarColorUtil {
  static Color getAppBarColor(String status) {
    switch (status) {
      case 'red':
        return Colors.red.withOpacity(0.8);
      case 'amber':
        return Colors.amber.withOpacity(0.8);
      case 'green':
        return Colors.green.withOpacity(0.8);
      default:
        return Colors.grey
            .withOpacity(0.8); // Default color if status is unknown
    }
  }
}
