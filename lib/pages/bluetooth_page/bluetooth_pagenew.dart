// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:opticheck/common/global/data_model.dart';
// import 'package:opticheck/common/global/global.dart';
// import 'package:opticheck/pages/sensorpage/sensor_page.dart';
// import 'package:opticheck/utils/back_icons.dart';
// import 'package:opticheck/utils/primary_button.dart';
// import 'package:provider/provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:permission_handler/permission_handler.dart';

// class BluetoothPageNew extends StatefulWidget {
//   const BluetoothPageNew({Key? key}) : super(key: key);

//   @override
//   _BluetoothPageNewState createState() => _BluetoothPageNewState();
// }

// class _BluetoothPageNewState extends State<BluetoothPageNew>
//     with ChangeNotifier {
//   BluetoothConnection? _connection;
//   bool _isConnecting = true;

//   @override
//   void initState() {
//     super.initState();
//     requestPermissions();
//   }

//   Future<void> requestPermissions() async {
//     if (await Permission.bluetoothScan.isGranted &&
//         await Permission.bluetooth.isGranted) {
//       // Permissions already granted
//       _connectToDevice();
//     } else {
//       // Request permissions
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.bluetoothScan,
//         Permission.bluetooth,
//         Permission.bluetoothConnect,
//       ].request();

//       if (statuses[Permission.bluetoothScan]!.isGranted &&
//           statuses[Permission.bluetooth]!.isGranted &&
//           statuses[Permission.bluetoothConnect]!.isGranted) {
//         _connectToDevice();
//       } else {
//         // Handle permissions not granted
//         print('Bluetooth permissions are not granted');
//       }
//     }
//   }

//   void bypassBluetoothConnection() async {
//     Navigator.pushNamed(context, '/selectionPage');
//   }

//   Future<void> _connectToDevice() async {
//     final navigator = Navigator.of(context);
//     final resultDataModel =
//         Provider.of<ResultDataModel>(context, listen: false);

//     try {
//       _connection = await BluetoothConnection.toAddress("00:23:00:00:49:65");
//       print('Connected to the device');

//       if (_connection != null && _connection!.isConnected) {
//         resultDataModel.updateBluetoothConnection(_connection);
//         notifyListeners();
//         // Navigator.pushNamed(context, '/sensorpage');
//         navigator.pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => SensorPage(connection: _connection),
//           ),
//         );
//       } else {
//         _updateConnectionStatus(false);
//       }
//     } catch (e) {
//       print("Error connecting to device: $e");
//       _updateConnectionStatus(false);
//     }

//     // Force rebuild after 10 seconds if still connecting
//     Timer(Duration(seconds: 5), () {
//       if (_isConnecting) {
//         _updateConnectionStatus(false);
//         _showConnectionErrorDialog();
//       }
//     });
//   }

//   void _updateConnectionStatus(bool isConnecting) {
//     setState(() {
//       _isConnecting = isConnecting;
//     });
//   }

//   void _showConnectionErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Device Not Connected"),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: Center(
//         child: _isConnecting
//             ? _buildConnectingWidget()
//             : _buildNotConnectedWidget(),
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: globalSecondaryColor.withOpacity(0.5),
//       title: Text(
//         _isConnecting ? 'Connecting...' : 'Not Connected',
//         style: TextStyle(
//           fontSize: calculateFontSize(context),
//           fontFamily: 'Merriweather',
//           fontWeight: globalFontWeight,
//         ),
//       ),
//       centerTitle: true,
//       automaticallyImplyLeading: false,
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 20.0, top: 5.0),
//         child: CustomBackIcon(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 20.0, top: 10.0),
//           child: GestureDetector(
//             onTap: () {
//               // Navigator.pushNamed(context, '/homepage');
//             },
//             child: SizedBox(
//               width: calculateIconSize(context) * 2,
//               height: calculateIconSize(context) * 2,
//               child: Image.asset(
//                 logoNoBgImage,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildConnectingWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 50,
//           height: 50,
//           child: Image.asset(bluetoothLogo, fit: BoxFit.contain),
//         ),
//         SizedBox(width: 20),
//         CircularProgressIndicator(),
//         SizedBox(width: 20),
//         Container(
//           width: 50,
//           height: 50,
//           child: Image.asset(motherboardLogo, fit: BoxFit.contain),
//         ),
//       ],
//     );
//   }

//   Widget _buildNotConnectedWidget() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: EdgeInsets.all(8),
//           child: Text(
//             "Ooops... Device not found\nplease Make sure Opti-Sensor is switched on and paired",
//             style: TextStyle(fontSize: 20),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         PrimaryButton(
//           buttonText: 'Retry',
//           onPressed: () {
//             _updateConnectionStatus(true);
//             _connectToDevice();
//           },
//         ),
//         ElevatedButton(
//           onPressed: bypassBluetoothConnection,
//           style: ElevatedButton.styleFrom(
//               backgroundColor: globalTertiaryColor.withOpacity(0.5)),
//           child: const Text(
//             'bypass',
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ],
//     );
//   }
// }
