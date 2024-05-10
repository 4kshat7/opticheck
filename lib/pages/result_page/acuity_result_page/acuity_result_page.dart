import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/large_glass_box.dart';
import 'package:provider/provider.dart';

class AcuityResultPage extends StatefulWidget {
  const AcuityResultPage({super.key});

  @override
  State<AcuityResultPage> createState() => _AcuityResultPageState();
}

class _AcuityResultPageState extends State<AcuityResultPage> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultDataModel>(builder: (context, value, child) {
      if (value.correctAcuityPlateCount != 0 &&
          value.correctAcuityPlateCount <= 8) {
        status = 'red';
      } else if (value.correctAcuityPlateCount > 8 &&
          value.correctAcuityPlateCount < 10) {
        status = 'amber';
      } else if (value.correctAcuityPlateCount >= 10) {
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
            _buildEyeIconAndStatus(
                context, status, value.correctAcuityPlateCount),
          ],
        ),
      );
    });
  }
}

// Helper function to build the eye icon and status text based on status
Widget _buildEyeIconAndStatus(
    BuildContext context, String status, int correctPlatesCount) {
  String statusText = '';
  String descText = '';
  Widget eyeIcon;

  switch (status) {
    case 'red':
      statusText = 'kharab ';
      descText = 'eye kharab hai';
      eyeIcon = Image.asset(eyeBadIcon);
      break;
    case 'amber':
      statusText = 'theek theek';
      descText = 'teri eye theek hai';
      eyeIcon = Image.asset(okstar);
      break;
    case 'green':
      statusText = 'bhadiya';
      descText = 'teri eye bhadiya hai ';

      eyeIcon = Image.asset(eyeGoodIcon);
      break;
    default:
      statusText = 'No Result';
      descText = 'Take the Acuity test to determine your distance vision.';
      eyeIcon = Image.asset(eyeAngle);
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
      Text(
        correctPlatesCount == 0 ? '' : '$correctPlatesCount Correct!',
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
