import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/acuity_page/logic/acuitytest_logic.dart';
import 'package:opticheck/utils/large_tap_box.dart';
import 'package:provider/provider.dart';
import 'package:opticheck/common/global/bluetoothconnectionprovider.dart';

class AcuitytestLandscape extends StatefulWidget {
  @override
  State<AcuitytestLandscape> createState() => _AcuitytestLandscapeState();
}

class _AcuitytestLandscapeState extends State<AcuitytestLandscape> {
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
      double referenceDistance = 130.0;
      double referenceSize = 150 * 2;
      double maxdist = 100;

      double testimgSize = 150;

      if (bluetoothProvider.connection != null) {
        testimgSize =
            (bluetoothProvider.displayData / referenceDistance) * referenceSize;
        testimgSize = testimgSize.clamp(10.0, referenceSize);
      }

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
                                      fontSize:
                                          calculateFontSize(context) / 1.5,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: globalFontFamily,
                                    ),
                                  )),
                            ]),
                    ),
                    AnimatedContainer(
                      // color: Colors.blueGrey,
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
                          : Center(
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
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
                      padding: const EdgeInsets.all(8.0),
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
    });
  }
}
