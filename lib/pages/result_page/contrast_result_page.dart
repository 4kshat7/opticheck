import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';

class ContrastResultPage extends StatefulWidget {
  const ContrastResultPage({super.key});

  @override
  State<ContrastResultPage> createState() => _ContrastResultPageState();
}

class _ContrastResultPageState extends State<ContrastResultPage> {
  String status = 'amber';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppBarColorUtil.getAppBarColor(status),
        title: Text(
          'Contrast Results',
          style: TextStyle(
            // color: Colors.amber.shade600,
            fontSize: calculateFontSize(context),
            fontFamily: 'Merriweather',
            fontWeight: globalFontWeight,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
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
        ],
      ),
      body: Center(
        child:
            SizedBox(height: 100, width: 100, child: Image.asset(dropperIcon)),
      ),
    );
  }
}
