import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/selection_page/selection_page.dart';
import 'package:opticheck/pages/selection_page/selection_page_landscape.dart';
import 'package:opticheck/common/responsive/responsive.dart';
import 'package:opticheck/utils/primary_button.dart';
import 'package:page_transition/page_transition.dart';

class LandscapeHomePage extends StatefulWidget {
  const LandscapeHomePage({Key? key}) : super(key: key);

  @override
  _LandscapeHomePageState createState() => _LandscapeHomePageState();
}

class _LandscapeHomePageState extends State<LandscapeHomePage> {
  double spreadRadius = 5;
  Timer? timer;
  double position = 0.0;

  bool isIconPressed = false;
  void iconPressed() {
    setState(() {
      isIconPressed = !isIconPressed;
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 500), (Timer t) {
      setState(() {
        spreadRadius = spreadRadius == 5 ? 25 : 5;
        position = position == 1.0 ? -1.0 : 1.0;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double logoSize = calculateLogoSize(context);

    return Scaffold(
      backgroundColor: globalBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: iconPressed,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: isIconPressed ? 0.6 : 1.0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  height: logoSize / 2,
                  width: logoSize / 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isIconPressed
                          ? Colors.grey.shade200
                          : globalBackgroundColor,
                    ),
                    boxShadow: isIconPressed
                        ? []
                        : [
                            BoxShadow(
                              color: globalSecondaryColor.withOpacity(0.25),
                              offset: Offset(6.0, 6.0),
                              blurRadius: 1.0,
                              spreadRadius: 5.0,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                    image: DecorationImage(
                      image: AssetImage(globalLogoImage),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style:
                    // DefaultTextStyle.of(context).style,
                    TextStyle(
                  fontSize:
                      calculateFontSize(context), // Use your global font size
                  fontFamily: 'Merriweather', // Use your global font family
                  fontWeight: globalFontWeight, // Use your global font weight
                  // Optionally, if you have global settings for text color and letter spacing, you can add them here
                  color:
                      globalPrimaryColor, // Assuming you have a global text color defined
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'See the World More Clearly with\n',
                  ),
                  TextSpan(
                    text: 'Opti',
                    style: TextStyle(
                      fontSize: calculateFontSize(context),
                      color:
                          primaryButtonBackgroundColor, // Change color as per your requirement
                      fontWeight: FontWeight
                          .bold, // Optionally, you can add more styling
                    ),
                  ),
                  TextSpan(
                      text: 'Check',
                      style: TextStyle(
                        fontSize: calculateFontSize(context),
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            PrimaryButton(
              buttonText: 'Get Started',
              onPressed: () {
                Navigator.pushNamed(context, '/selectionPage');
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'OptiCheck Project Team - Akshat , Hardik & Sonu 2024 ©',
                style: TextStyle(
                    fontSize: calculateFontSize(context) / 2,
                    fontStyle: FontStyle.italic,
                    color: globalPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
