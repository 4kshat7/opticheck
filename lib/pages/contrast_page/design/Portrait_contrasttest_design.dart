import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/contrast_page/logic/contrasttest_logic.dart';
import 'package:opticheck/utils/interactive_circle.dart';
import 'package:provider/provider.dart';

class ContrastTestPortrait extends StatelessWidget {
  const ContrastTestPortrait({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ContrastTestLogicController>(
        builder: (context, controller, child) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(title: Text("Interactive Circle")),
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
                  duration: const Duration(milliseconds: 100),
                  height: calculateIconSize(context) * 2,
                  width: calculateIconSize(context) * 2,
                  child: Image.asset(controller.currentPlate.imagePath,
                      // landolt_U,
                      color: Colors.grey[controller.greyshade]),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    InteractiveCircle(
                      segments: 8,
                      size: calculateInteractiveCircleSize(context) / 1.2,
                      onTap: (segmentIndex) {
                        controller.nextPlate(context, segmentIndex, 0);
                        // print("Segment $segmentIndex tapped");
                      },
                    ),
                    // Container(
                    //   // Small white circle in the center

                    //   width: 170,
                    //   height: 170,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     shape: BoxShape.circle,
                    //   ),
                    // ),

                    // Text(
                    //   // segmentdisplay.toString(),
                    //   controller.greyshade.toString() +
                    //       '\n' +
                    //       controller.correctContrastPlatesCount.toString(),
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: calculateFontSize(context)),
                    // ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: controller.iconOpacity,
                      child: Container(
                        height: calculateIconSize(context) * 2,
                        width: calculateIconSize(context) * 2,
                        child: controller.whichIcon
                            ? Image.asset(tickIcon)
                            : Image.asset(crossIcon),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
