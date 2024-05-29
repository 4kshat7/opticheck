import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/large_glass_box.dart';
import 'package:provider/provider.dart';

class ContrastResultPage extends StatefulWidget {
  const ContrastResultPage({super.key});

  @override
  State<ContrastResultPage> createState() => _ContrastResultPageState();
}

class _ContrastResultPageState extends State<ContrastResultPage> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultDataModel>(builder: (context, value, child) {
      if ((value.correctLeftContrastPlatesCount != 0 &&
              value.correctLeftContrastPlatesCount <= 8) ||
          (value.correctRightContrastPlatesCount != 0 &&
              value.correctRightContrastPlatesCount <= 8)) {
        status = 'red';
      } else if ((value.correctLeftContrastPlatesCount > 8 &&
              value.correctLeftContrastPlatesCount < 10) ||
          (value.correctRightContrastPlatesCount > 8 &&
              value.correctRightContrastPlatesCount < 10)) {
        status = 'amber';
      } else if (value.correctLeftContrastPlatesCount >= 10 ||
          value.correctRightContrastPlatesCount >= 10) {
        status = 'green';
      }

      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: AppBarColorUtil.getAppBarColor(status),
          title: Text(
            'Contrast Results',
            style: TextStyle(
              // color: Colors.amber.shade600,
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
                  // Navigator.pop(context);
                  Navigator.pushNamed(context, '/selectionPage');
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
          children: [
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
            _buildEyeIconAndStatus(
                context,
                status,
                value.correctLeftContrastPlatesCount,
                value.correctRightContrastPlatesCount),
          ],
        ),
      );
    });
  }
}

// Helper function to build the eye icon and status text based on status
Widget _buildEyeIconAndStatus(BuildContext context, String status,
    int correctLeftPlatesCount, int correctRightPlatesCount) {
  // correctLeftPlatesCount = 11;
  // correctRightPlatesCount = 9;
  String statusText = '';
  String descText = '';
  Widget eyeIcon;
  String Lefteyestate = '';
  String Righteyestate = '';

//Left and right of  palte count and eyestate are reversed because the plaate count represent the hand covering...
  if (correctLeftPlatesCount <= 8) {
    Righteyestate = badeyestate;
  } else if ((correctLeftPlatesCount > 8 && correctLeftPlatesCount < 10)) {
    Righteyestate = okeyestate;
  } else if (correctLeftPlatesCount >= 10 || correctLeftPlatesCount >= 10) {
    Righteyestate = goodeyestate;
  }

  if (correctRightPlatesCount <= 8) {
    Lefteyestate = badeyestate;
  } else if ((correctRightPlatesCount > 8 && correctRightPlatesCount < 10)) {
    Lefteyestate = okeyestate;
  } else if (correctRightPlatesCount >= 10 || correctRightPlatesCount >= 10) {
    Lefteyestate = goodeyestate;
  }

  switch (status) {
    case 'red':
      statusText = 'Visual Impairment';
      descText =
          'Our results indicate poor vision contrast. You may struggle to distinguish between different shades of gray, which could affect your ability to perceive details in images or visual stimuli.';
      eyeIcon = Image.asset(badcontrast);
      break;
    case 'amber':
      statusText = 'Mild Visual Impairment';
      descText =
          'Your vision contrast test results suggest an average ability to discern between different shades of gray. While you may encounter some difficulty in distinguishing subtle contrasts, your vision should generally allow you to perceive visual details adequately.';
      eyeIcon = Image.asset(okcontrast);
      break;
    case 'green':
      statusText = 'Normal Vision Contrast';
      descText =
          'Congratulations! Your vision contrast test results indicate excellent contrast sensitivity. You possess a keen ability to distinguish between various shades of gray, enabling you to perceive visual details with precision and clarity.';

      eyeIcon = Image.asset(goodcontrast);
      break;
    default:
      statusText = 'No Result';
      descText =
          'Take the Contrast test to determine which category best describes your contrast vision.';
      eyeIcon = Image.asset(dropperIcon);
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(
        height: 100,
        width: 100,
        child: eyeIcon,
      ),
      // Container(
      //   height: calculateLogoSize(context) / 4,
      //   width: calculateLogoSize(context) / 4,
      //   child: Lottie.network(
      //       'https://lottie.host/1d50b1d2-ac5f-4225-9b38-b7d4a2258898/HlpE3G1sAb.json'),
      // ),
      correctLeftPlatesCount == 0
          ? Text('')
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Left-Eye:',
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
                SizedBox(
                  height: calculateIconSize(context) * 1.5,
                  width: calculateIconSize(context) * 1.5,
                  child: Image.asset(Lefteyestate),
                ),
                Text(
                  'Right-Eye:',
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
                SizedBox(
                  height: calculateIconSize(context) * 1.5,
                  width: calculateIconSize(context) * 1.5,
                  child: Image.asset(Righteyestate),
                ),
              ],
            ),
      Center(
        child: LargeGlassBox(
          MainText: statusText,
          SecondaryText: descText,
          MainTextFontSize: calculateFontSize(context) * 1.3,
          SecondaryTextFontSize: calculateFontSize(context),
          height: calculateBoxSize(context) * 2.5,
          width: calculateBoxSize(context) * 2.5,
          color: AppBarColorUtil.getAppBarColor(status),
          // imagePath: DefaultColorBlindIcon,
          // bottomLeftIconData: Icons.info,
          // infoText: VCinfo,
          bottomRightImageData: 'lib/assets/images/opticheck_nobg.png',
          // onTapAction: () {
          //   print('Second box tapped!');
          // },
        ),
      ),

      // Text(
      //   statusText,
      //   textAlign: TextAlign.center,
      //   style: TextStyle(
      //     fontSize: 18,
      //     color: AppBarColorUtil.getAppBarColor(status),
      //   ),
      // ),
      // Text(
      //   descText,
      //   style: TextStyle(
      //     fontSize: 24,
      //     color: AppBarColorUtil.getAppBarColor(status),
      //   ),
      // ),
    ],
  );
}
