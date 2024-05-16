import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/large_glass_box.dart';
import 'package:provider/provider.dart';

class LandscapeAcuityResultPage extends StatefulWidget {
  const LandscapeAcuityResultPage({super.key});

  @override
  State<LandscapeAcuityResultPage> createState() =>
      _LandscapeAcuityResultPageState();
}

class _LandscapeAcuityResultPageState extends State<LandscapeAcuityResultPage> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultDataModel>(builder: (context, value, child) {
      if ((value.Left_logMarvalue > 0.5 && value.Left_logMarvalue <= 1) ||
          (value.Right_logMarvalue > 0.5 && value.Right_logMarvalue <= 1)) {
        status = 'red';
      } else if ((value.Left_logMarvalue <= 0.5 &&
              value.Left_logMarvalue > 0.0) ||
          (value.Right_logMarvalue <= 0.5 && value.Right_logMarvalue > 0.0)) {
        status = 'amber';
      } else if (value.Left_logMarvalue <= 0.0 ||
          value.Right_logMarvalue <= 0.0) {
        status = 'green';
      }

      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: AppBarColorUtil.getAppBarColor(status),
          title: Text(
            'Acuity Results',
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
            _buildEyeIconAndStatus(context, status, value.Left_logMarvalue,
                value.Right_logMarvalue),
          ],
        ),
      );
    });
  }
}

// Helper function to build the eye icon and status text based on status
Widget _buildEyeIconAndStatus(BuildContext context, String status,
    double leftlogmarvalue, double rightlogmarvalue) {
  String statusText = '';
  String descText = '';
  Widget eyeIcon;

  String acuityCategory = '';

  String leftEyeResult = '';
  String rightEyeResult = '';

  if (leftlogmarvalue == 2 || rightlogmarvalue == 2) {
    acuityCategory = 'No result';
  } else if (leftlogmarvalue <= 0 && rightlogmarvalue <= 0) {
    acuityCategory = 'Perfect vision in both eyes';
  } else if (leftlogmarvalue == rightlogmarvalue) {
    acuityCategory = 'Oculus uterque (OU) - both eyes';
  } else if (leftlogmarvalue < rightlogmarvalue) {
    acuityCategory = 'Oculus sinister (OS) - left eye';
  } else if (leftlogmarvalue > rightlogmarvalue) {
    acuityCategory = 'Oculus dexter (OD) - right eye';
  }

  switch (rightlogmarvalue) {
    case 1.00:
      leftEyeResult = '20/200';
    case 0.90:
      leftEyeResult = '20/160';
    case 0.80:
      leftEyeResult = '20/125';
    case 0.70:
      leftEyeResult = '20/100';
    case 0.60:
      leftEyeResult = '20/80';
    case 0.50:
      leftEyeResult = '20/63';
    case 0.40:
      leftEyeResult = '20/50';
    case 0.30:
      leftEyeResult = '20/40';
    case 0.20:
      leftEyeResult = '20/32';
    case 0.10:
      leftEyeResult = '20/25';
    case 0.00:
      leftEyeResult = '20/20';
    case -0.10:
      leftEyeResult = '20/12.5';
    case -0.30:
      leftEyeResult = '20/10';
  }
  switch (leftlogmarvalue) {
    case 1.00:
      rightEyeResult = '20/200';
    case 0.90:
      rightEyeResult = '20/160';
    case 0.80:
      rightEyeResult = '20/125';
    case 0.70:
      rightEyeResult = '20/100';
    case 0.60:
      rightEyeResult = '20/80';
    case 0.50:
      rightEyeResult = '20/63';
    case 0.40:
      rightEyeResult = '20/50';
    case 0.30:
      rightEyeResult = '20/40';
    case 0.20:
      rightEyeResult = '20/32';
    case 0.10:
      rightEyeResult = '20/25';
    case 0.00:
      rightEyeResult = '20/20';
    case -0.10:
      rightEyeResult = '20/12.5';
    case -0.30:
      rightEyeResult = '20/10';
  }

  switch (rightlogmarvalue) {}

  switch (status) {
    case 'red':
      // statusText = 'kharab ';
      descText =
          'Our results indicate significant visual acuity impairment. You may have considerable difficulty in seeing objects clearly at various distances, which could impact daily activities and overall quality of life. Severe impairment, such as 20/200 vision, means you see at 20 feet what a normal person sees at 200 feet, highlighting the need for comprehensive ophthalmologic evaluation. ';
      eyeIcon = Image.asset(eyeBadIcon);
      break;
    case 'amber':
      // statusText = 'theek theek';
      descText =
          'Your visual acuity test results suggest moderate difficulty in seeing objects clearly at different distances. While you may manage most tasks, you might experience challenges in situations requiring sharp vision. Visual acuity is determined by the smallest detail you can discern, with 20/40 vision indicating that you see at 20 feet what a normal person sees at 40 feet.';
      eyeIcon = Image.asset(okstar);
      break;
    case 'green':
      // statusText = 'bhadiya';
      descText =
          'Congratulations! Your visual acuity test results indicate normal vision. You have excellent ability to see objects clearly at various distances, allowing you to perform daily tasks with ease and precision. Visual acuity is crucial for assessing the clarity or sharpness of vision';

      eyeIcon = Image.asset(eyeGoodIcon);
      break;
    default:
      // statusText = 'No Result';
      descText = 'Take the Acuity test to determine your distance vision.';
      eyeIcon = Image.asset(eyeAngle);
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          leftlogmarvalue == 2
              ? Text('')
              : Text(
                  'Left-Eye: $leftEyeResult \nRight-Eye: $rightEyeResult',
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
      Center(
        child: LargeGlassBox(
          MainText: acuityCategory,
          SecondaryText: descText,
          MainTextFontSize: calculateFontSize(context) * 1.3,
          SecondaryTextFontSize: calculateFontSize(context) / 1.3,
          height: calculateBoxSize(context) * 2.5,
          // imagePath: goodeyestate,
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
