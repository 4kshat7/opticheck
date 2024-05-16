import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/EyeCoverScreen.dart';
import 'package:opticheck/utils/back_icons.dart';
import 'package:opticheck/utils/primary_button.dart';

class LandscapeAcuityInstructionPage extends StatelessWidget {
  const LandscapeAcuityInstructionPage({super.key});

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  width: calculateLogoSize(context) / 1.2,
                  height: calculateLogoSize(context) / 1.2,
                  child: Image.asset(acuityinstruction)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Text(
                //   "You'll be presented with four options to choose from. Simply tap on the corresponding option number that you see. If you don't see any number, tap on the 'none' option instead.",
                //   style: TextStyle(
                //       fontSize: calculateFontSize(context),
                //       fontStyle: FontStyle.normal,
                //       color: globalPrimaryColor,
                //       fontWeight: globalFontWeight),
                //   textAlign: TextAlign.justify,
                // ),
                Container(
                  width: calculateLogoSize(context) / 2,
                  height: calculateLogoSize(context) / 1.5,
                  // width: double
                  //     .infinity, // Ensures the container takes all available width
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: 16.0), // Adjust padding as needed
                  child: Text(
                    "You will be shown a letter on the screen. Please choose the corresponding option from the four choices displayed below. if you answer incorrectly more than twice, your score will be evaluated automatically for each eye.",
                    // textAlign: TextAlign.center,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: calculateFontSize(context) / 1.2,
                        fontWeight: globalFontWeight,
                        color: globalPrimaryColor),
                    // softWrap: true,
                    // overflow: TextOverflow.visible,
                  ),
                ),
                PrimaryButton(
                    buttonText: 'Start Test',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Eyecoverscreen(
                                  routeName: '/leftacuitytestpage',
                                  whichEye: 'left')));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
