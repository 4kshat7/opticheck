import 'dart:async';
// import 'dart:math';
// import 'dart:ui_web';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:opticheck/common/global/global.dart';
// import 'package:opticheck/pages/bluetooth_page.dart';
import 'package:opticheck/utils/primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double spreadRadius = 5;
  Timer? timer;
  double position = 0.0;

  bool isIconPressed = false;
  void iconPressed() {
    setState(() {
      if (isIconPressed == false) {
        isIconPressed = true;
        playerAudioFromPath('button_in.mp3');
      } else if (isIconPressed == true) {
        isIconPressed = false;
        playerAudioFromPath('button_out.mp3');
      }
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

  // int _getRandomDuration() {
  //   return Random().nextInt(700) + 500;
  // }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double logoSize = calculateLogoSize(context);
    ;

    return Scaffold(
      backgroundColor: globalBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: iconPressed,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 250),
                          opacity: isIconPressed ? 0.6 : 1.0,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                            height: logoSize,
                            width: logoSize,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color: Colors.grey,
                                border: Border.all(
                                  color: isIconPressed
                                      ? Colors.grey.shade200
                                      : globalBackgroundColor,
                                ),
                                // color: Colors.blue,
                                //   boxShadow: [
                                //     BoxShadow(
                                //         color: primaryButtonBackgroundColor
                                //             .withOpacity(0.1),
                                //         blurRadius: spreadRadius * 2,
                                //         spreadRadius: spreadRadius)
                                //   ],
                                //   image: DecorationImage(
                                //     image: AssetImage(globalLogoImage),
                                //     fit: BoxFit.contain,
                                //   ),
                                boxShadow: isIconPressed
                                    ? [
                                        //no shadows
                                      ]
                                    : [
                                        BoxShadow(
                                          color: globalSecondaryColor
                                              .withOpacity(0.25),
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
                                )),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 100,
                      //   child: Text(
                      //     calculateCurrentWidth(context).toInt().toString(),
                      //     style:
                      //         TextStyle(fontSize: calculateFontSize(context)),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style:
                              // DefaultTextStyle.of(context).style,
                              TextStyle(
                            fontSize: calculateFontSize(
                                context), // Use your global font size
                            fontFamily:
                                'Merriweather', // Use your global font family
                            fontWeight:
                                globalFontWeight, // Use your global font weight
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

                      // Text(
                      //   ' See the World More Clearly with \n OptiCheck',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: calculateFontSize(
                      //         context), // Use your global font size
                      //     fontFamily:
                      //         'Merriweather', // Use your global font family
                      //     fontWeight:
                      //         globalFontWeight, // Use your global font weight
                      //     // Optionally, if you have global settings for text color and letter spacing, you can add them here
                      //     color:
                      //         globalPrimaryColor, // Assuming you have a global text color defined
                      //   ),
                      // ),
                      SizedBox(height: 70),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
