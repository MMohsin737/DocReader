import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_admob/firebase_admob.dart';

import '../providers/save_data.dart';
import '../widgets/list_view_builder.dart';
// import '../widgets/check_wifi.dart';
// import '../helpers/file_get_storage.dart';
// import '../helpers/ad_manager_helper.dart';

class FileListView extends StatefulWidget {
  static const pageRoute = '/list-view';
  @override
  _FileListViewState createState() => _FileListViewState();
}

class _FileListViewState extends State<FileListView> {
  File docFileSelected;
  // bool _interstitialAdFlag = false;
  // BannerAd _bannerAd;

  @override
  void initState() {
    // FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    // _bannerAd = AdManager.getBannerAd();
    // _bannerAd.load().then(
    //       (value) => _interstitialAdFlag = value,
    //     );
    // _bannerAd.show(
    //   anchorType: AnchorType.top,
    //   // anchorOffset: MediaQuery.of(context).size.height - 500,
    //   // horizontalCenterOffset: 5,
    // );
    super.initState();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    super.dispose();
  }

  // ignore: unused_element
  void _showSnackBar(BuildContext ctx, int time, String message) {
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: time),
        backgroundColor: Theme.of(ctx).primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: FutureBuilder(
        future:
            Provider.of<SaveData>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<SaveData>(
              builder: (ctx, saveData, ch) => saveData.items.length != 0
                  ? ListViewBuilder(saveData.items)
                  : ch,
              child: Center(child: Text('No File Selected')),
            );
          }
        },
      ),
    );
  }
}
