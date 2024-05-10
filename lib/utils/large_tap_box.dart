import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart'; // Make sure this contains your global styles/colors

class LargeTappableArea extends StatelessWidget {
  final String text;
  final String infoText;
  final double height;
  final double width;
  final VoidCallback onTapAction;
  final String? imagePath;
  final String? bottomRightImageData;
  final IconData? bottomLeftIconData;
  final double? MainTextFontSize;
  final double? NoneTextFontSize;
  final Color color;

  LargeTappableArea(
      {this.text = 'Lable not found',
      this.infoText = 'Info not found',
      this.height = 200.0,
      this.width = 350.0,
      required this.onTapAction,
      this.imagePath,
      this.bottomLeftIconData,
      this.bottomRightImageData,
      this.color = globalSecondaryColor,
      required this.MainTextFontSize,
      this.NoneTextFontSize = 20});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: globalBackgroundColor.withOpacity(0.5),
      highlightColor: Colors.transparent,
      onTap: onTapAction,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
          boxShadow: [
            BoxShadow(
              color: globalSecondaryColor.withOpacity(0.25),
              offset: Offset(4.0, 4.0),
              blurRadius: 1.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 1.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (bottomLeftIconData != null)
              Positioned(
                left: 8,
                bottom: 8,
                child: Tooltip(
                  message: infoText,
                  // Customize this message for each box
                  decoration: BoxDecoration(
                    color: globalPrimaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: calculateFontSize(context) / 1.4,
                  ),
                  padding: EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {},
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Icon(
                        bottomLeftIconData,
                        size: backIconSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
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
                  Text(
                    text,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.blue.shade900.withOpacity(1),
                            offset: Offset(0.5, 0.5),
                            blurRadius: 0.5,
                          ),
                        ],
                        fontSize: text == 'none'
                            ? NoneTextFontSize
                            : MainTextFontSize,
                        fontFamily: 'Merriweather',
                        fontWeight: globalFontWeight,
                        color: globalBackgroundColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
