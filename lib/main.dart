import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/file_list_view.dart';
import './widgets/camera_view.dart';
import './screens/image_scan_screen.dart';
import './screens/scan_screen.dart';
import './screens/home_screen.dart';
import './screens/bottom_naviagtion_screen.dart';
import './screens/local_screen.dart';
import './providers/save_data.dart';
import './screens/splash_screen.dart';
// import './screens/view_list_doc_main.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(MyApp());
}

const MaterialColor blueAppThemePrimary = const MaterialColor(
  0xFF407bff,
  const <int, Color>{
    50: const Color.fromRGBO(64, 123, 255, 0.05),
    100: const Color.fromRGBO(64, 123, 255, 0.1),
    200: const Color.fromRGBO(64, 123, 255, 0.2),
    300: const Color.fromRGBO(64, 123, 255, 0.3),
    400: const Color.fromRGBO(64, 123, 255, 0.4),
    500: const Color.fromRGBO(64, 123, 255, 0.5),
    600: const Color.fromRGBO(64, 123, 255, 0.6),
    700: const Color.fromRGBO(64, 123, 255, 0.7),
    800: const Color.fromRGBO(64, 123, 255, 0.8),
    900: const Color.fromRGBO(64, 123, 255, 0.9),
  },
);

const MaterialColor backGroundApp = const MaterialColor(
  0xFFebebeb,
  const <int, Color>{
    50: const Color.fromRGBO(235, 235, 235, 0.05),
    100: const Color.fromRGBO(235, 235, 235, 0.1),
    200: const Color.fromRGBO(235, 235, 235, 0.2),
    300: const Color.fromRGBO(235, 235, 235, 0.3),
    400: const Color.fromRGBO(235, 235, 235, 0.4),
    500: const Color.fromRGBO(235, 235, 235, 0.5),
    600: const Color.fromRGBO(235, 235, 235, 0.6),
    700: const Color.fromRGBO(235, 235, 235, 0.7),
    800: const Color.fromRGBO(235, 235, 235, 0.8),
    900: const Color.fromRGBO(235, 235, 235, 0.9),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle().copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return ChangeNotifierProvider.value(
      value: SaveData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: blueAppThemePrimary,
          accentColor: Colors.lightBlueAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
                headline3: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontSize: 18,
                ),
                headline4: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontSize: 16,
                ),
              ),
        ),
        initialRoute: SplashScreen.pageRoute,
        // initialRoute: '/',
        routes: {
          SplashScreen.pageRoute: (ctx) => SplashScreen(),
          BottomNavigationScreen.pageRoute: (ctx) => BottomNavigationScreen(),
          HomeScreen.pageRoute: (ctx) => HomeScreen(),
          FileListView.pageRoute: (ctx) => FileListView(),
          // FlieReaderScreen.routePage: (ctx) => FlieReaderScreen(''),
          ScanScreen.pageRoute: (ctx) => ScanScreen(),
          ImageScanScreen.pageRoute: (ctx) => ImageScanScreen(),
          CamerViewWidget.routePage: (ctx) => CamerViewWidget(),
          LocalScreen.pageRoute: (ctx) => LocalScreen(),
          // ViewListDocMain.pageRoute: (ctx) => ViewListDocMain(),
        },
      ),
    );
  }
}
