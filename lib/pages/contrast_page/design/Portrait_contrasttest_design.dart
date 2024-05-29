import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/contrast_page/logic/contrasttest_logic.dart';
import 'package:opticheck/utils/interactive_circle.dart';
import 'package:provider/provider.dart';
import 'package:opticheck/common/global/bluetoothconnectionprovider.dart';

class ContrastTestPortrait extends StatefulWidget {
  const ContrastTestPortrait({super.key});

  @override
  State<ContrastTestPortrait> createState() => _ContrastTestPortraitState();
}

class _ContrastTestPortraitState extends State<ContrastTestPortrait> {
  @override
  void initState() {
    super.initState();
    final provider =
        Provider.of<BluetoothConnectionProvider>(context, listen: false);
    if (provider.connection != null) {
      provider.sendMessage('O');
    }
  }

  @override
  void dispose() {
    // _sendMessage('X');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothConnectionProvider>(
        builder: (context, bluetoothProvider, child) {
      // double testimgSize = 10 + bluetoothProvider.displayData;
      // testimgSize = testimgSize.clamp(10.0, 100.0);

      double referenceDistance = 130.0;
      double referenceSize = calculateIconSize(context) * 4;
      double maxdist = 100.0;

      double testimgSize = calculateIconSize(context) * 2;

      if (bluetoothProvider.connection != null) {
        testimgSize =
            (bluetoothProvider.displayData / referenceDistance) * referenceSize;
        testimgSize = testimgSize.clamp(10.0, referenceSize);
      }

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
                    height: calculateIconSize(context) * 3,
                    width: calculateIconSize(context) * 3,
                    child: bluetoothProvider.connection == null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Text(
                              'SENSOR NOT CONNECTED!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: calculateFontSize(context) / 2,
                                fontWeight: FontWeight.bold,
                                fontFamily: globalFontFamily,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Stack(children: [
                            Lottie.network(
                                'https://lottie.host/1d50b1d2-ac5f-4225-9b38-b7d4a2258898/HlpE3G1sAb.json'),
                            Center(
                              child: SizedBox(
                                height: calculateIconSize(context),
                                width: calculateIconSize(context),
                                // child: Image.asset(sensorWave),
                              ),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  bluetoothProvider.displayData.toString() +
                                      ' cm',
                                  // textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: calculateFontSize(context) / 1.5,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: globalFontFamily,
                                  ),
                                )),
                            // Align(
                            //     alignment: Alignment.bottomCenter,
                            //     child: Text(testimgSize.toInt().toString())),
                          ]),
                  ),
                  // Text(bluetoothProvider.displayData.toString() + ''),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: testimgSize,
                    width: testimgSize,
                    child: bluetoothProvider.displayData > maxdist
                        ? Text(
                            'Face Not Detected!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: calculateFontSize(context),
                              fontWeight: FontWeight.bold,
                              fontFamily: globalFontFamily,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Image.asset(controller.currentPlate.imagePath,
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
    });
  }
}
