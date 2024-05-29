import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:opticheck/common/global/bluetoothconnectionprovider.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/sensorpage/sensor_page.dart';
import 'package:opticheck/utils/back_icons.dart';
import 'package:opticheck/utils/primary_button.dart';
import 'package:provider/provider.dart';

class BluetoothPageNew2 extends StatefulWidget {
  const BluetoothPageNew2({Key? key}) : super(key: key);

  @override
  _BluetoothPageStateNew2 createState() => _BluetoothPageStateNew2();
}

class _BluetoothPageStateNew2 extends State<BluetoothPageNew2> {
  Timer? _timer;
  late BluetoothConnection _connection;
  bool _isConnecting = true;

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // void _connectToDevice() async {
  //   final navigator = Navigator.of(context);

  //   try {
  //     _connection = await BluetoothConnection.toAddress("00:23:00:00:49:65");
  //     print('Connected to the device');

  //     if (_connection != null && _connection.isConnected) {
  //       navigator.pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => SensorPage(connection: _connection!),
  //         ),
  //       );
  //     } else {
  //       _isConnecting = false;
  //     }

  //     _isConnecting = false;
  //   } catch (e) {
  //     print("Error connecting to device: $e");

  //     // If connection fails, set the flag to false
  //     _isConnecting = false;
  //   }}
  void _connectToDevice() {
    final provider =
        Provider.of<BluetoothConnectionProvider>(context, listen: false);
    provider.connect("00:23:00:00:49:65").then((_) {
      if (provider.connection != null && provider.connection!.isConnected) {
        Navigator.pushReplacementNamed(context, '/selectionPage');

        provider.startListening();
        
      }
    });

    // Force rebuild after 10 seconds, regardless of connection status
    _timer = Timer(Duration(seconds: 10), () {
      if (_isConnecting) {
        setState(() {
          _isConnecting = false;
        });
        // Show a dialog or set a state to indicate device not connected
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Device Not Connected "),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globalSecondaryColor.withOpacity(0.5),
        title: _isConnecting
            ? Text(
                'Connecting...',
                style: TextStyle(
                  fontSize: calculateFontSize(context),
                  fontFamily: 'Merriweather',
                  fontWeight: globalFontWeight,
                ),
              )
            : Text(
                'Not Connected',
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
        child: _isConnecting
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Image.asset(bluetoothLogo, fit: BoxFit.contain),
                  ),
                  SizedBox(width: 20),
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Container(
                    width: 50,
                    height: 50,
                    child: Image.asset(motherboardLogo, fit: BoxFit.contain),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Ooops... Device not found\nplease Make sure Opti-Sensor is switched on and paired",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  PrimaryButton(
                    buttonText: 'Retry',
                    onPressed: () {
                      setState(() {
                        _isConnecting = true;
                      });
                      _connectToDevice();
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/selectionPage');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: globalTertiaryColor.withOpacity(0.5)),
                    child: const Text(
                      'bypass',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
