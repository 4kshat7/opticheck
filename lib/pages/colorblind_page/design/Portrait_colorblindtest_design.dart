import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/colorblind_page/logic/colorbindtest_logic.dart';
import 'package:opticheck/utils/large_tap_box.dart';
import 'package:provider/provider.dart';

class ColorblindTestPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ColorblindTestLogicController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: calculateLogoSize(context),
                width: calculateLogoSize(context),
                child: Image.asset(
                  controller.currentPlate.imagePath,
                ),
              ),
              Text(
                'Choose what you see from the options below.',
                style: TextStyle(
                  fontSize: calculateFontSize(context) / 1.2,
                  fontWeight: globalFontWeight,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    4,
                    (index) => LargeTappableArea(
                          text: controller.labels[index] != 0
                              ? '${controller.labels[index]}'
                              : 'none',
                          MainTextFontSize: calculateFontSize(context) * 2,
                          NoneTextFontSize: calculateFontSize(context) * 1.3,
                          height: calculateBoxSize(context) / 2.5,
                          width: calculateBoxSize(context) / 2.5,
                          color: controller.labelColors[index],
                          onTapAction: () => controller.nextPlate(
                              context, controller.labels[index], index),
                        )),
              )
            ],
          ),
        );
      },
    );
  }
}
