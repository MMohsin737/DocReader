import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';

import './build_list_tile.dart';

class AppDrawer extends StatelessWidget {
  final String homeScanTitle;
  final Function scanFileFunc;

  AppDrawer({
    this.homeScanTitle,
    this.scanFileFunc,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width / 1.5,
      decoration: BoxDecoration(
        color: Color.fromRGBO(235, 235, 235, 1),
      ),
      child: Drawer(
        elevation: 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: mediaQuery.size.height / 4,
              width: double.infinity,
              child: Center(
                child: Text(
                  'DOC Reader',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                ),
                // child: Image.asset(
                //   'assets/images/appicon.png',
                //   fit: BoxFit.fitWidth,
                // ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BuildTileList(
              displayIcon: (homeScanTitle == 'Home')
                  ? Icons.home
                  : Ionicons.md_qr_scanner,
              tileText: homeScanTitle,
              callBackHandler: scanFileFunc,
            ),
            BuildTileList(
              displayIcon: Ionicons.md_star_outline,
              tileText: 'Rate Us',
              callBackHandler: () {
                StoreRedirect.redirect(
                  androidAppId: "com.doc.reader.all.pdf.files",
                  iOSAppId: "",
                );
                Navigator.of(context).pop();
              },
            ),
            BuildTileList(
                displayIcon: Ionicons.md_share,
                tileText: 'Share',
                callBackHandler: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(
                    (Platform.isAndroid)
                        ? 'Check out our App:\nhttps://play.google.com/store/apps/details?id=com.doc.reader.all.pdf.files'
                        : 'Check out our App:\nhttps://apps.apple.com/us/app/apple-store/id',
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size,
                  );
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
