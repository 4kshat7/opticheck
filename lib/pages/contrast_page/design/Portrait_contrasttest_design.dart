import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/interactive_circle.dart';

class ContrastTestPortrait extends StatefulWidget {
  @override
  State<ContrastTestPortrait> createState() => _ContrastTestPortraitState();
}

class _ContrastTestPortraitState extends State<ContrastTestPortrait> {
  int segmentdisplay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: Text("Interactive Circle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: calculateLogoSize(context),
              width: calculateLogoSize(context),
              child: Image.asset(
                landolt_UR,
                color: Colors.grey[500],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                InteractiveCircle(
                  segments: 8,
                  size: calculateInteractiveCircleSize(context) / 1.2,
                  onTap: (segmentIndex) {
                    setState(() {
                      segmentdisplay = segmentIndex.toInt();
                    });

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
                Text(
                  segmentdisplay.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: calculateFontSize(context)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
