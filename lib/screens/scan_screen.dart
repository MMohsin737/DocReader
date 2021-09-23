import 'package:doc_reader/screens/image_scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_icons/flutter_icons.dart';

//import '../widgets/build_list_tile.dart';
import '../widgets/app_drawer.dart';

class ScanScreen extends StatelessWidget {
  static const pageRoute = '/scan-screen';
  // List<String> _storedImage = [];

  void openCam(BuildContext ctx) async {
    await Navigator.pushNamed(ctx, ImageScanScreen.pageRoute);
  }

  // ignore: missing_return
  Future<bool> backToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () => backToHome(context),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        appBar: AppBar(
          elevation: 0,
        ),
        // Navigator.pushReplacementNamed(context, '/');
        drawer: AppDrawer(
          homeScanTitle: 'Home',
          scanFileFunc: () => Navigator.pushReplacementNamed(context, '/'),
        ),
        body: Container(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: mediaQuery.size.height / 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(55)),
                      ),
                    ),
                    Positioned(
                      top: mediaQuery.size.height / 40,
                      left: mediaQuery.size.width / 25,
                      child: Container(
                        width: mediaQuery.size.width - 18,
                        child: Image.asset(
                          'assets/images/scanTop.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        child: InkWell(
                          onTap: () => openCam(context),
                          child: Container(
                            width: mediaQuery.size.width / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              'assets/images/button.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Text(
                        'Scan Document',
                        style: TextStyle(
                          color: Color.fromRGBO(83, 83, 83, 0.55),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
