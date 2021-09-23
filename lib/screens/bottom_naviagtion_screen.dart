import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import '../helpers/ad_manager_helper.dart';
import 'package:admob_flutter/admob_flutter.dart';

import './file_list_view.dart';
import './home_screen.dart';
import './local_screen.dart';
import '../widgets/app_drawer.dart';
import './scan_screen.dart';
import '../helpers/permission_handel_app.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const pageRoute = '/';
  @override
  _BottomNavigationScreen createState() => _BottomNavigationScreen();
}

class _BottomNavigationScreen extends State<BottomNavigationScreen> {
  int selectedPos = 1;
  bool _permissionGranted = false;
  CircularBottomNavigationController _navigationController;
  static Color circleColor;
  AdmobInterstitial _interstitialAd;

  @override
  void initState() {
    initFunc();
    super.initState();
  }

  void initFunc() async {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle().copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
    askPermission();
    _navigationController = new CircularBottomNavigationController(selectedPos);
    // FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId)
    Admob.initialize(AdManager.appId);
    _interstitialAd = AdManager.getInterstialAd();
    _interstitialAd.load();
  }

  @override
  void didChangeDependencies() {
    if (_permissionGranted != true) {
      askPermission();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  void askPermission() async {
    _permissionGranted = await PermissionHandelApp.getPermissions(context);
    if (_permissionGranted) {
      setState(() {
        _permissionGranted = true;
      });
    } else {
      setState(() {
        _permissionGranted = false;
      });
    }
  }

  // ignore: missing_return
  Future<bool> geBackHomeScreen() {
    if (selectedPos > 1 && selectedPos > 0) {
      setState(() {
        // selectedPos--;
        _navigationController.value--;
      });
    } else if (selectedPos < 1 && selectedPos < 2) {
      setState(() {
        // selectedPos++;
        _navigationController.value++;
      });
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  List<TabItem> tabItems = List.of([
    new TabItem(
      Icons.access_time,
      "Recent",
      circleColor,
      labelStyle: TextStyle(
        color: circleColor,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w700,
      ),
    ),
    new TabItem(
      Icons.home,
      "Home",
      circleColor,
      labelStyle: TextStyle(
        color: circleColor,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w700,
      ),
    ),
    new TabItem(
      Ionicons.ios_folder_open,
      "Local",
      circleColor,
      labelStyle: TextStyle(
        color: circleColor,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w700,
      ),
    ),
  ]);

  Widget bodyContainer() {
    Widget page;
    switch (selectedPos) {
      case 0:
        page = FileListView();
        break;
      case 1:
        page = HomeScreen();
        break;
      case 2:
        page = LocalScreen();
        break;
      default:
        break;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: page,
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      circleSize: 60,
      circleStrokeWidth: 3,
      iconsSize: 32.0,
      selectedPos: selectedPos,
      controller: _navigationController,
      barHeight: MediaQuery.of(context).size.height / 15,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        print('Inside Bottom Navs');
        setState(() {
          this.selectedPos = selectedPos;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    circleColor = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: geBackHomeScreen,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        appBar: AppBar(
          elevation: 0,
        ),
        drawer: AppDrawer(
          homeScanTitle: 'Scan Document',
          scanFileFunc: () {
            _interstitialAd.isLoaded.then((value) {
              if (value) {
                _interstitialAd.show();
              } else {
                return;
              }
            });
            Navigator.pushReplacementNamed(context, ScanScreen.pageRoute);
          },
        ),
        body: bodyContainer(),
        bottomNavigationBar: bottomNav(),
      ),
    );
  }
}
