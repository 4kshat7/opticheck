import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart'; // Make sure this contains your global styles/colors

class LargeGlassBox extends StatelessWidget {
  final String MainText;
  final String SecondaryText;
  final double height;
  final double width;
  final String? imagePath;
  final String? bottomRightImageData;
  // final IconData? bottomLeftIconData;
  final double? MainTextFontSize;
  final double? SecondaryTextFontSize;
  final Color color;
  // final _borderRadius = BorderRadius.circular(20);

  LargeGlassBox(
      {this.MainText = 'MainText not found',
      this.SecondaryText = 'Secondary not found',
      this.height = 300.0,
      this.width = 450.0,
      this.imagePath,
      // this.bottomLeftIconData,
      this.bottomRightImageData,
      this.color = Colors.grey,
      required this.MainTextFontSize,
      this.SecondaryTextFontSize});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: width,
        height: height,
        // color: globalSecondaryColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.8),
                        Colors.white.withOpacity(0.1),
                      ])),
            ),
            // from here box content starts
            if (bottomRightImageData != null)
              Positioned(
                right: 8,
                bottom: 8,
                child: Image.asset(
                  bottomRightImageData!,
                  width: calculateIconSize(context) * 1.3,
                  height: calculateIconSize(context) * 1.3,
                  fit: BoxFit.cover,
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      imagePath!,
                      width: calculateIconSize(context) * 2.5,
                      height: calculateIconSize(context) * 2.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                Container(
                  width: double
                      .infinity, // Ensures the container takes all available width
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0), // Adjust padding as needed
                  child: Text(
                    MainText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.blue.shade900.withOpacity(1),
                            offset: Offset(0.5, 0.5),
                            blurRadius: 0.5,
                          ),
                        ],
                        fontSize: MainTextFontSize,
                        fontWeight: globalFontWeight,
                        color: globalBackgroundColor),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                ),
                Container(
                  width: double
                      .infinity, // Ensures the container takes all available width
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0), // Adjust padding as needed
                  child: Text(
                    SecondaryText,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.blue.shade900.withOpacity(1),
                            // color: Colors.black.withOpacity(1),
                            offset: Offset(0.5, 0.5),
                            blurRadius: 0.5,
                          ),
                        ],
                        fontSize: SecondaryTextFontSize,
                        fontWeight: globalFontWeight,
                        color: globalSecondaryColor),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
