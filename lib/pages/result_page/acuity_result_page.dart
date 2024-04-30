import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/utils/back_icons.dart';

class AcuityResultPage extends StatefulWidget {
  const AcuityResultPage({super.key});

  @override
  State<AcuityResultPage> createState() => _AcuityResultPageState();
}

class _AcuityResultPageState extends State<AcuityResultPage> {
  String status = 'green';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppBarColorUtil.getAppBarColor(status),
        title: Text(
          'Acuity Results',
          style: TextStyle(
            // color: Colors.amber.shade600,
            fontSize: calculateFontSize(context),
            fontFamily: 'Merriweather',
            fontWeight: globalFontWeight,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 20.0, top: 5.0),
        //   child: CustomBackIcon(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        actions: [
          // Stack(
          //   children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 10.0),
            child: GestureDetector(
              onTap: () {
                // Navigator.pop(context);
                Navigator.popUntil(
                    context, ModalRoute.withName('/selectionPage'));
              },
              child: SizedBox(
                width: calculateIconSize(context) * 1.5,
                height: calculateIconSize(context) * 1.5,
                child: Image.asset(
                  testGlassesIcon,
                  color: Colors.white,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          //       Positioned(
          //         right: 20,
          //         top: 10,
          //         child: AnimatedContainer(
          //           duration: Duration(milliseconds: 500),
          //           padding: EdgeInsets.all(4),
          //           decoration: BoxDecoration(
          //             color: _notifiColor
          //                 ? Colors.blue.shade300
          //                 : Colors.amber,
          //             shape: BoxShape.circle,
          //           ),
          //           // child: Text(
          //           //   '1', // You can replace this with any indication
          //           //   style: TextStyle(
          //           //     color: Colors.white,
          //           //     fontSize: 12,
          //           //     fontWeight: FontWeight.bold,
          //           //   ),
          //           // ),
          //         ),
          //       ),
          //     ],
          //   ),
        ],
      ),
      body: Center(
        child:
            SizedBox(height: 100, width: 100, child: Image.asset(eyeGoodIcon)),
      ),
    );
  }
}
