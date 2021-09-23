import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:admob_flutter/admob_flutter.dart';

import '../helpers/ad_manager_helper.dart';
import './bottom_naviagtion_screen.dart';

class SplashScreen extends StatefulWidget {
  static const pageRoute = '/splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // InterstitialAd _interstitialAd;
  AdmobInterstitial _interstitialAd;
  bool _opacityValue1 = false;
  bool _opacityValue2 = false;
  bool _opacityValue3 = false;
  bool _opacityValue4 = false;

  @override
  void initState() {
    appStartUp();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle().copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    Admob.initialize(AdManager.appId);
    _interstitialAd = AdManager.getInterstialAd(handler: moveToMainScreen);
    _interstitialAd.load();
    super.initState();
  }

  void moveToMainScreen() {
    Navigator.pushReplacement(
      context,
      _createRoute(),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  void appStartUp() {
    Future.delayed(
      Duration(
        milliseconds: 0,
      ),
      () => setState(() {
        _opacityValue1 = true;
      }),
    ).whenComplete(
      () => Future.delayed(
        Duration(
          milliseconds: 1500,
        ),
        () => setState(() {
          _opacityValue2 = true;
        }),
      )
          .whenComplete(
            () => Future.delayed(
              Duration(
                milliseconds: 1000,
              ),
              () => setState(() {
                _opacityValue3 = true;
              }),
            ),
          )
          .whenComplete(
            () => Future.delayed(
              Duration(
                milliseconds: 1000,
              ),
              () => setState(() {
                _opacityValue4 = true;
              }),
            ),
          )
          .whenComplete(
            () => Future.delayed(
              Duration(
                milliseconds: 5500,
              ),
              moveToHomeScreen,
            ),
          ),
    );
  }

  void changeOpacity() {
    setState(() {
      _opacityValue1 = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void moveToHomeScreen() {
    _interstitialAd.isLoaded.then((value) {
      if (value) {
        _interstitialAd.show();
      } else {
        return;
      }
    });
    moveToMainScreen();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          BottomNavigationScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: _opacityValue1 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeInOut,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Container(
                  child: Image.asset(
                    'assets/images/splashimage.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AnimatedOpacity(
              opacity: _opacityValue2 == false ? 0.0 : 1.0,
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              child: Text(
                'Document Reader',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 28,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _opacityValue3 == false ? 0.0 : 1.0,
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              child: Text(
                'Read & Scan All Your\nDocuments',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AnimatedOpacity(
              opacity: _opacityValue4 == false ? 0.0 : 1.0,
              duration: Duration(milliseconds: 1000),
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
