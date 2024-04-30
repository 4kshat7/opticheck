import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';

class CustomBackIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBackIcon({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        size: calculateIconSize(context),
        color: backIconColor,
      ),
      onPressed: onPressed,
    );
  }
}
