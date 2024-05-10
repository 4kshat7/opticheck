import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:opticheck/common/global/data_model.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:opticheck/pages/bluetooth_page/bluetooth_page.dart';
import 'package:opticheck/pages/colorblind_page/design/Portrait_colorblindtest_design.dart';
import 'package:opticheck/pages/colorblind_page/design/landscape_colorblindtest_design.dart';
import 'package:opticheck/pages/colorblind_page/logic/colorbindtest_logic.dart';
import 'package:opticheck/pages/contrast_page/design/Landscape_contrasttest_design.dart';
import 'package:opticheck/pages/contrast_page/design/Portrait_contrasttest_design.dart';
import 'package:opticheck/pages/contrast_page/logic/contrasttest_logic.dart';
import 'package:opticheck/pages/home_page/home_page.dart';
import 'package:opticheck/pages/home_page/home_page_landscape.dart';
import 'package:opticheck/pages/instruction_pages/colorblind_instruction_page.dart';
import 'package:opticheck/pages/instruction_pages/contrast_instruction_page.dart';
import 'package:opticheck/pages/instruction_pages/landscape_colorblind_instruction_page.dart';
import 'package:opticheck/pages/instruction_pages/landscape_contrast_instruction_page.dart';
import 'package:opticheck/pages/result_page/acuity_result_page/acuity_result_page.dart';
import 'package:opticheck/pages/result_page/acuity_result_page/landscape_acuity_result_page.dart';
import 'package:opticheck/pages/result_page/colorblind_result_page/colorblind_result_page.dart';
import 'package:opticheck/pages/result_page/colorblind_result_page/landscape_colorblind_result_page.dart';
import 'package:opticheck/pages/result_page/contrast_result_page/contrast_result_page.dart';
import 'package:opticheck/pages/result_page/contrast_result_page/landscape_contrast_result_page.dart';
import 'package:opticheck/pages/result_page/result_page_main.dart';
import 'package:opticheck/pages/selection_page/selection_page.dart';
import 'package:opticheck/pages/selection_page/selection_page_landscape.dart';
import 'package:opticheck/common/responsive/responsive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> requestBluetoothPermissions() async {
  // Request BLUETOOTH_SCAN permission
  var bluetoothScanStatus = await Permission.bluetooth.status;
  if (!bluetoothScanStatus.isGranted) {
    await Permission.bluetoothScan.request();
  }

  // Request BLUETOOTH_CONNECT permission
  var bluetoothConnectStatus = await Permission.bluetoothConnect.status;
  if (!bluetoothConnectStatus.isGranted) {
    await Permission.bluetoothConnect.request();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ResultDataModel(),
      child: const MyApp(),
    ),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestBluetoothPermissions();
    });
    return MaterialApp(
      title: 'OptiCheck',
      theme: ThemeData(
        scaffoldBackgroundColor: globalBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Request Bluetooth to be enabled
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, snapshot) {
          // Corrected the conditional logic based on connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading spinner while waiting for Bluetooth to enable
            return Scaffold(
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            // Bluetooth is enabled, navigate to HomePage
            if (snapshot.data == true) {
              // If Bluetooth is enabled successfully
              return ResponsiveLayout(
                mobileBody: HomePage(),
                landscapeBody: LandscapeHomePage(),
              );
            } else {
              // User did not enable Bluetooth or an error occurred
              return ResponsiveLayout(
                mobileBody: HomePage(),
                landscapeBody: LandscapeHomePage(),
              );
              //     Scaffold(
              //   body: Center(
              //     child: Text(
              //       'Bluetooth is not enabled. Please enable Bluetooth to use the app.',
              //       style: TextStyle(fontSize: 20, color: globalPrimaryColor),
              //     ),
              //   ),
              // );
            }
          } else {
            // Handle error or other states
            return Scaffold(
              body: Center(
                child: Text('Error enabling Bluetooth. Please try again.'),
              ),
            );
          }
        },
      ),
      // initialRoute: '/homePage',
      routes: {
        '/homepage': (context) => ResponsiveLayout(
              mobileBody: HomePage(),
              landscapeBody: LandscapeHomePage(),
            ),

        // '/selectionpage': (context) => ResponsiveLayout(
        //       mobileBody: SelectionPage(),
        //       landscapeBody: LandscapeSelectionPage(),
        //     ),
        // '/sensorpage': (context) => SensorPage(connection: BluetoothManager().connection),

        '/bluetoothpage': (context) => const BluetoothPage(),

//result pages
        '/acuityresultpage': (context) => ResultPageMain(pages: [
              ResponsiveLayout(
                  mobileBody: AcuityResultPage(),
                  landscapeBody: LandscapeAcuityResultPage()),
              ResponsiveLayout(
                  mobileBody: ContrastResultPage(),
                  landscapeBody: LandscapeContrastResultPage()),
              ResponsiveLayout(
                  mobileBody: ColorblindResultPage(),
                  landscapeBody: LandscapeColorblindResultPage()),
            ]),

        '/contrastresultpage': (context) => ResultPageMain(pages: [
              ResponsiveLayout(
                  mobileBody: ContrastResultPage(),
                  landscapeBody: LandscapeContrastResultPage()),
              ResponsiveLayout(
                  mobileBody: ColorblindResultPage(),
                  landscapeBody: LandscapeColorblindResultPage()),
              ResponsiveLayout(
                  mobileBody: AcuityResultPage(),
                  landscapeBody: LandscapeAcuityResultPage()),
            ]),

        '/colorblindresultpage': (context) => ResultPageMain(pages: [
              ResponsiveLayout(
                  mobileBody: ColorblindResultPage(),
                  landscapeBody: LandscapeColorblindResultPage()),
              ResponsiveLayout(
                  mobileBody: AcuityResultPage(),
                  landscapeBody: LandscapeAcuityResultPage()),
              ResponsiveLayout(
                  mobileBody: ContrastResultPage(),
                  landscapeBody: LandscapeContrastResultPage()),
            ]),

//instruction pages
        '/colorblindinstructionpage': (context) => ResponsiveLayout(
              mobileBody: ColorblindInstructionPage(),
              landscapeBody: LandscapeColorblindInstructionPage(),
            ),
        '/contrastinstructionpage': (context) => ResponsiveLayout(
              mobileBody: ContrastInstructionPage(),
              landscapeBody: LandscapeContrastInstructionPage(),
            ),

//test pages
        '/contrasttestpage': (context) =>
            ChangeNotifierProvider<ContrastTestLogicController>(
              create: (_) => ContrastTestLogicController(context),
              child: ResponsiveLayout(
                mobileBody: ContrastTestPortrait(),
                landscapeBody: ContrastTestLandscape(),
              ),
            ),
        '/colorblindtestpage': (context) =>
            ChangeNotifierProvider<ColorblindTestLogicController>(
              create: (_) => ColorblindTestLogicController(context),
              child: ResponsiveLayout(
                mobileBody: ColorblindTestPortrait(),
                landscapeBody: ColorblindTestLandscape(),
              ),
            ),
      },
//animated transition pages
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/selectionPage':
            return PageTransition(
              child: ResponsiveLayout(
                mobileBody: SelectionPage(),
                landscapeBody: LandscapeSelectionPage(),
              ),
              type: PageTransitionType.rightToLeftWithFade,
              settings: settings,
              duration: Duration(milliseconds: 500),
            );
          case '/homePage':
            return PageTransition(
              child: ResponsiveLayout(
                mobileBody: HomePage(),
                landscapeBody: LandscapeHomePage(),
              ),
              type: PageTransitionType.leftToRightWithFade,
              settings: settings,
              duration: Duration(milliseconds: 500),
            );
          default:
            return MaterialPageRoute(builder: (_) => HomePage());
        }
      },
    );
  }
}
