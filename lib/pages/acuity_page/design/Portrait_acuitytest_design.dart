import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/acuity_page/logic/acuitytest_logic.dart';
import 'package:opticheck/utils/large_tap_box.dart';
import 'package:provider/provider.dart';

class AcuityTestPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AcuitytestLogicController>(
      builder: (context, controller, child) {
        // print(
        //     'controller.labels: ${controller.currentPlate!.letter}, Index : ${controller.currentPlateIndex}, labels genereted : ${controller.labels}');
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: calculateIconSize(context) * 2,
                    width: calculateIconSize(context) * 2,
                    child: Stack(children: [
                      Lottie.network(
                          'https://lottie.host/1d50b1d2-ac5f-4225-9b38-b7d4a2258898/HlpE3G1sAb.json'),
                      Center(
                        child: SizedBox(
                          height: calculateIconSize(context),
                          width: calculateIconSize(context),
                          child: Image.asset(sensorWave),
                        ),
                      )
                    ]),
                  ),
                  AnimatedContainer(
                    // color: Colors.blueGrey,
                    duration: const Duration(milliseconds: 100),
                    height: 150,
                    width: 150,
                    child: Center(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          // Calculate the font size based on the container size and fontSizeMm
                          double fontSize =
                              controller.currentPlate!.fontSizeMm *
                                  (constraints.biggest.shortestSide /
                                      150); // Adjust scaling as needed

                          return Text(
                            controller.currentPlate!.letter,
                            style: TextStyle(
                              fontFamily: 'Sloan',
                              fontWeight: FontWeight.normal,
                              fontSize: fontSize,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Text(
                    'logMARValue : ${controller.currentPlate!.logMARValue}',
                    style: TextStyle(
                      fontSize: calculateFontSize(context) / 1.2,
                      fontWeight: globalFontWeight,
                    ),
                  ),
                  // Text(
                  //   'Choose what you see from the options below.',
                  //   style: TextStyle(
                  //     fontSize: calculateFontSize(context) / 1.2,
                  //     fontWeight: globalFontWeight,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          4,
                          (index) => LargeTappableArea(
                                text: '${controller.labels[index]}',
                                MainTextFontSize:
                                    calculateFontSize(context) * 2,
                                NoneTextFontSize:
                                    calculateFontSize(context) * 1.3,
                                height: calculateBoxSize(context) / 2.5,
                                width: calculateBoxSize(context) / 2.5,
                                color: controller.labelColors[index],
                                onTapAction: () => controller.nextPlate(
                                    context, controller.labels[index], index),
                              )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
