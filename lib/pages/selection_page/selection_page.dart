import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/common/responsive/responsive.dart';
import 'package:opticheck/pages/home_page/home_page.dart';
import 'package:opticheck/pages/home_page/home_page_landscape.dart';
import 'package:opticheck/pages/result_page/acuity_result_page.dart';
import 'package:opticheck/pages/result_page/result_page_main.dart';
import 'package:opticheck/utils/back_icons.dart';
import 'package:opticheck/utils/primary_button.dart';
import 'package:opticheck/utils/large_tap_box.dart';
import 'package:page_transition/page_transition.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  bool _isAnimationCompleted = false;
  bool _isResult = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimationCompleted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: globalBackgroundColor,
        appBar: AppBar(
          backgroundColor: globalSecondaryColor.withOpacity(0.5),
          title: Text(
            'Vision Test',
            style: TextStyle(
              fontSize: calculateFontSize(context),
              fontFamily: 'Merriweather',
              fontWeight: globalFontWeight,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0),
            child: CustomBackIcon(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     child: ResponsiveLayout(
                //       mobileBody: HomePage(),
                //       landscapeBody: LandscapeHomePage(),
                //     ),
                //     type: PageTransitionType.leftToRightWithFade,
                //     duration: Duration(milliseconds: 500),
                //   ),
                // );
                Navigator.pushNamed(context, '/homePage');
              },
            ),
          ),
          actions: [
            // Stack(
            //   children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 10.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     child: ResultPageMain(),
                  //     type: PageTransitionType.fade,
                  //     duration: Duration(milliseconds: 200),
                  //   ),
                  // );
                  Navigator.pushNamed(context, '/resultpage');
                },
                child: SizedBox(
                  width: calculateIconSize(context),
                  height: calculateIconSize(context),
                  child: Image.asset(
                    _isResult ? analysisIconYellow : analysisIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            //       Positioned(
            //         right: 20,
            //         top: 10,
            //         child: AnimatedContainer(
            //           duration: Duration(milliseconds: 500),
            //           padding: EdgeInsets.all(4),
            //           decoration: BoxDecoration(
            //             color: _notifiColor
            //                 ? Colors.blue.shade300
            //                 : Colors.amber,
            //             shape: BoxShape.circle,
            //           ),
            //           // child: Text(
            //           //   '1', // You can replace this with any indication
            //           //   style: TextStyle(
            //           //     color: Colors.white,
            //           //     fontSize: 12,
            //           //     fontWeight: FontWeight.bold,
            //           //   ),
            //           // ),
            //         ),
            //       ),
            //     ],
            //   ),
          ],
        ),

        // body: SingleChildScrollView(
        // child:
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 650),
                curve: Curves.bounceOut,
                height: _isAnimationCompleted ? calculateBoxSize(context) : 0,
                width:
                    _isAnimationCompleted ? calculateBoxSize(context) * 1.9 : 0,
                child: LargeTappableArea(
                  text: 'Visual Acuity',
                  MainTextFontSize: calculateFontSize(context) * 1.3,
                  height: calculateBoxSize(context),
                  width: calculateBoxSize(context) * 1.9,
                  imagePath: 'lib/assets/images/snellen-test.png',
                  bottomLeftIconData: Icons.info,
                  infoText: VAinfo,
                  bottomRightImageData: 'lib/assets/images/opticheck_nobg.png',
                  onTapAction: () {
                    Navigator.pushNamed(context, '/bluetoothpage');
                  },
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 750),
                curve: Curves.bounceOut,
                height: _isAnimationCompleted ? calculateBoxSize(context) : 0,
                width:
                    _isAnimationCompleted ? calculateBoxSize(context) * 1.9 : 0,
                child: LargeTappableArea(
                  text: 'Vision Contrast',
                  MainTextFontSize: calculateFontSize(context) * 1.3,
                  height: calculateBoxSize(context),
                  width: calculateBoxSize(context) * 1.9,
                  imagePath: 'lib/assets/images/contrast.png',
                  bottomLeftIconData: Icons.info,
                  infoText: VCinfo,
                  bottomRightImageData: 'lib/assets/images/opticheck_nobg.png',
                  onTapAction: () {
                    print('Second box tapped!');
                  },
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 900),
                curve: Curves.bounceOut,
                height: _isAnimationCompleted ? calculateBoxSize(context) : 0,
                width:
                    _isAnimationCompleted ? calculateBoxSize(context) * 1.9 : 0,
                child: LargeTappableArea(
                  text: 'Color Blind Test',
                  MainTextFontSize: calculateFontSize(context) * 1.3,
                  height: calculateBoxSize(context),
                  width: calculateBoxSize(context) * 1.9,
                  imagePath: 'lib/assets/images/color-blind.png',
                  bottomLeftIconData: Icons.info,
                  infoText: CBinfo,
                  bottomRightImageData: 'lib/assets/images/opticheck_nobg.png',
                  onTapAction: () {
                    Navigator.pushNamed(context, '/colorblindtestpage');
                    print('Third box tapped!');
                  },
                ),
              ),

              Text(
                'Tap and Hold the info-icon on the left to know about the test',
                style: TextStyle(
                    fontSize: calculateFontSize(context) / 2,
                    // fontFamily: 'Merriweather',
                    // fontWeight: ,
                    color: globalPrimaryColor),
              ),
              // Container(
              //   height: calculateLogoSize(context) / 4,
              //   width: calculateLogoSize(context) / 4,
              //   child: Lottie.network(
              //       'https://lottie.host/1d50b1d2-ac5f-4225-9b38-b7d4a2258898/HlpE3G1sAb.json'),
              // ),
              Text(
                'OptiCheck Team 2024 ©',
                style: TextStyle(
                    fontSize: calculateFontSize(context) / 2,
                    fontStyle: FontStyle.italic,
                    color: globalPrimaryColor),
              ),
            ],
            // ),
          ),
        ));
  }
}
