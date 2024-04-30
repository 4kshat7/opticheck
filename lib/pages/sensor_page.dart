import 'dart:async'; // For Timer

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert';

import 'package:opticheck/common/global/global.dart';
import 'package:flutter/foundation.dart';

class SensorPage extends StatefulWidget {
  final BluetoothConnection connection;

  const SensorPage({Key? key, required this.connection}) : super(key: key);

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  Timer? _timer;
  String _dist = "0.00";
  // double _prevDist = 0.00;
  double display_data = 0.00;
  double max_dist = 125;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    double prevDist = 0.00;
    widget.connection.input!.listen((Uint8List data) {
      double newDist = double.tryParse(utf8.decode(data)) ?? 0.00;
      setState(() {
        display_data = double.tryParse(ascii.decode(data)) ?? 0.00;
      });
      if ((newDist - prevDist).abs() >= 3.00) {
        setState(() {
          _dist = utf8.decode(data);
          prevDist = newDist;
        });
      }
    }).onDone(() {
      // Handle connection being closed
    });

    // Optionally, set up a Timer if you need to perform actions periodically
    // _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) => _checkData());
  }

  // Example function if you need to poll or check data periodically
  // void _checkData() {
  //   // Perform actions every 100 ms, if needed
  // }

  void _sendMessage(String message) async {
    widget.connection.output.add(Uint8List.fromList(utf8.encode(message)));
    await widget.connection.output.allSent;
    if (message == 'O') {
      playerAudioFromPath('sensor_beep.mp3');
    }
    if (kDebugMode) {
      print("Command sent: $message");
    }
  }

  @override
  Widget build(BuildContext context) {
    double dist = double.tryParse(_dist) ?? 0.00;
    double fontSize = 10 + dist;
    fontSize = fontSize.clamp(10.0, 100.0);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dist < max_dist
                          ? fontSize.toInt().toString()
                          // ? 'A'
                          : 'FACE NOT DETECTED!',
                      style: TextStyle(
                        fontSize: dist < max_dist
                            ? fontSize
                            : 50, // Increased text size
                        fontWeight: FontWeight.bold,
                        fontFamily: globalFontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Other widgets can go here
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dist < max_dist
                  ? display_data.toString() + ' cm'
                  // : 'ALIGN SENSOR TO FACE',
                  : display_data.toString() + ' cm',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontFamily: globalFontFamily,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => _sendMessage('O'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dist < max_dist
                        ? primaryButtonBackgroundColor
                        : Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  child: const Text(
                    'On',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _sendMessage('X'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dist < max_dist
                        ? primaryButtonBackgroundColor
                        : Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  child: const Text(
                    'Off',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                    height: 20), // To give some spacing at the bottom
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
