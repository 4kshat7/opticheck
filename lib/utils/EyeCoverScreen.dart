import 'dart:async';
import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';

class Eyecoverscreen extends StatefulWidget {
  final String routeName;
  final String whichEye;

  Eyecoverscreen({required this.routeName, required this.whichEye});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<Eyecoverscreen> {
  late Timer _timer;
  int _countdown = 5;
  bool _whicheye = true;

  @override
  void initState() {
    super.initState();
    if (widget.whichEye == 'left') {
      _whicheye = true;
    } else {
      _whicheye = false;
    }
    _startCountdown();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown <= 1) {
        _timer.cancel();
        Navigator.pushNamed(context, widget.routeName);
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Countdown Page'),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Text(
              //   'Image Here',
              //   style: TextStyle(fontSize: 20.0),
              // ),
              SizedBox(
                  height: calculateLogoSize(context) / 2,
                  width: calculateLogoSize(context) / 2,
                  child: _whicheye
                      ? Image.asset(lefteyecover)
                      : Image.asset(righteyecover)),
              Text(
                'Cover your ${widget.whichEye} eye.',
                style: TextStyle(
                    fontSize: calculateFontSize(context) * 1.5,
                    fontFamily: globalFontFamily,
                    fontWeight: globalFontWeight,
                    color: globalPrimaryColor),
              ),
              Text(
                'Starting in $_countdown seconds',
                style: TextStyle(fontSize: calculateFontSize(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     initialRoute: '/',
//     routes: {
//       '/': (context) => Eyecoverscreen(routeName: '/other', whichEye: 'Right'),
//       '/other': (context) => Scaffold(
//             appBar: AppBar(
//               title: Text('Other Page'),
//             ),
//             body: Center(
//               child: Text('Other Page Content'),
//             ),
//           ),
//     },
//   ));
// }
