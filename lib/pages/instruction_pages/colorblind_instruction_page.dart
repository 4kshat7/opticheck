import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/back_icons.dart';
import 'package:opticheck/utils/primary_button.dart';

class ColorblindInstructionPage extends StatelessWidget {
  const ColorblindInstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globalSecondaryColor.withOpacity(0.5),
        title: Text(
          'Test Instructions',
          style: TextStyle(
            fontSize: calculateFontSize(context),
            fontFamily: 'Merriweather',
            fontWeight: globalFontWeight,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // backgroundColor: globalBackgroundColor.withOpacity(0.5),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 5.0),
          child: CustomBackIcon(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 10.0),
            child: GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/homepage');
              },
              child: SizedBox(
                width: calculateIconSize(context) * 2,
                height: calculateIconSize(context) * 2,
                child: Image.asset(
                  logoNoBgImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                  width: calculateLogoSize(context),
                  height: calculateLogoSize(context),
                  child: Image.asset(colorBlindInstruction)),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                "You'll be presented with four options to choose from. Simply tap on the corresponding option that you see. If you don't see any number, tap on the 'none' option instead.",
                style: TextStyle(
                    fontSize: calculateFontSize(context) / 1.2,
                    fontStyle: FontStyle.normal,
                    fontWeight: globalFontWeight),
                textAlign: TextAlign.justify,
              ),
            ),
            PrimaryButton(
                buttonText: 'Start Test',
                onPressed: () {
                  Navigator.pushNamed(context, '/colorblindtestpage');
                }),
          ],
        ),
      ),
    );
  }
}
