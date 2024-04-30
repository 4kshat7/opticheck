import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  // const ResponsiveLayout({super.key});
  final Widget mobileBody;
  final Widget landscapeBody;

  ResponsiveLayout({required this.mobileBody, required this.landscapeBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrants) {
      if (constrants.maxWidth >= constrants.maxHeight) {
        return landscapeBody;
      } else {
        return mobileBody;
      }
    });
  }
}
