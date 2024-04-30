import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/utils/large_glass_box.dart';
import 'package:provider/provider.dart';

class ColorblindResultPage extends StatefulWidget {
  // final int correctPlatesCount;
  const ColorblindResultPage({
    super.key,
    // this.correctPlatesCount = 0
  });

  @override
  State<ColorblindResultPage> createState() => _ColorblindResultPageState();
}

class _ColorblindResultPageState extends State<ColorblindResultPage> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultDataModel>(
      builder: (context, value, child) {
        // Update status based on correctPlatesCount
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
              _buildEyeIconAndStatus(context, status, value.correctPlatesCount),
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     LargeGlassBox(
          //       text: 'Test Glass Box',
          //       MainTextFontSize: calculateFontSize(context) * 1.3,
          //       height: calculateBoxSize(context) * 1.5,
          //       width: calculateBoxSize(context) * 2.5,
          //       imagePath: DefaultColorBlindIcon,
          //       // bottomLeftIconData: Icons.info,
          //       infoText: VCinfo,
          //       // bottomRightImageData: 'lib/assets/images/opticheck_nobg.png',
          //       // onTapAction: () {
          //       //   print('Second box tapped!');
          //       // },
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}

Widget _buildEyeIcon(String status) {
  switch (status) {
    case 'red':
      return Image.asset(BadcolorBlindEyeIcon);
    case 'amber':
      return Image.asset(OkcolorBlindEyeIcon);
    case 'green':
      return Image.asset(GoodcolorBlindEyeIcon);
    default:
      return Image.asset(DefaultColorBlindIcon);
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
      statusText = 'Category: Protanopia or Deuteranopia';
      descText =
          'You might have "Total red-green" color blindness. Protanopia is the inability to see red light, while deuteranopia affects green perception. Both conditions can impact tasks like reading traffic lights or identifying certain colors accurately.';
      eyeIcon = Image.asset(BadcolorBlindEyeIcon);
      break;
    case 'amber':
      statusText = 'Category: Protanomaly or Deuteranomaly';
      descText =
          'You might have "partial red-green" color blindness. Affecting the perception of red and green hues. Protanomaly makes it difficult to see red properly.Deuteranomaly affects green perception. Individuals with these conditions may have trouble distinguishing between certain shades of red and green';
      eyeIcon = Image.asset(OkcolorBlindEyeIcon);
      break;
    case 'green':
      statusText = 'You have trichromatic vision';
      descText =
          'You have a perfectly healthy color vision, you can perceive a full range of colors by using three types of cone cells in the eyes: red, green, and blue. This allows for accurate differentiation between various hues and shades across the visible spectrum.';

      eyeIcon = Image.asset(GoodcolorBlindEyeIcon);
      break;
    default:
      statusText = 'No Result';
      descText =
          'Take the Color-blind test to determine which category best describes your color vision.';
      eyeIcon = Image.asset(DefaultColorBlindIcon);
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
        correctPlatesCount == plates.length - 1
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
      LargeGlassBox(
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
