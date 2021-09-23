import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import '../screens/file_reader_screen.dart';
import '../providers/save_data.dart';
import 'file_viewer.dart';
import '../helpers/ad_manager_helper.dart';

class ListViewBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> listItems;

  ListViewBuilder(this.listItems);

  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  AdmobBanner _bannerAd;
  AdmobInterstitial _interstitialAd;

  @override
  void initState() {
    Admob.initialize(AdManager.appId);
    _bannerAd = AdManager.getBannerAd();
    _interstitialAd = AdManager.getInterstialAd();
    _interstitialAd.load();
    super.initState();
  }

  void _showToastRes(BuildContext ctx, {String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Theme.of(ctx).primaryColor,
      textColor: Colors.white,
    );
  }

  void removeItem(BuildContext ctx, String id) async {
    int res;
    res = await Provider.of<SaveData>(ctx, listen: false).deleteItem(id);
    if (res != 0) {
      _showToastRes(
        ctx,
        message: 'Item Deleted Sccessfuly!',
      );
    } else {
      _showToastRes(
        ctx,
        message: 'Item Not Deleted!',
      );
    }
  }

  String getIcon(String key) {
    if (key == 'pdf') {
      return 'assets/images/pdf.png';
    } else if (key == 'doc' || key == 'docx') {
      return 'assets/images/word.png';
    } else if (key == 'ppt' || key == 'pptx') {
      return 'assets/images/ppt.png';
    } else if (key == 'xls' || key == 'xlsx') {
      return 'assets/images/xls.png';
    } else if (key == 'txt') {
      return 'assets/images/txt.png';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.listItems.length,
      separatorBuilder: (context, index) {
        return Container(
          child: (index != 0 && index % 3 == 0)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: _bannerAd,
                )
              : Container(),
        );
      },
      itemBuilder: (context, i) {
        return Card(
          elevation: 0,
          color: Color.fromRGBO(235, 235, 235, 1),
          child: Dismissible(
            key: ValueKey(DateTime.now().toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme.of(context).primaryColor,
              child: Icon(
                Icons.delete,
                color: Colors.white38,
                size: 40,
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Image.asset(
                    '${getIcon(widget.listItems[i]['docpath'].split('.').last)}',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                  title: Text(
                    widget.listItems[i]['docpath']
                        .split('/')
                        .last
                        .split('.')
                        .first,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  onTap: () async {
                    _interstitialAd.isLoaded.then((value) {
                      if (value) {
                        _interstitialAd.show();
                      } else {
                        return;
                      }
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) {
                        // return FlieReaderScreen(widget.listItems[i]['docpath']);
                        return WebViewViewer(
                          getPath: widget.listItems[i]['docpath'],
                        );
                      }),
                    );
                  },
                ),
                Divider(
                  indent: 80,
                  color: Color.fromRGBO(57, 57, 57, 0.5),
                ),
              ],
            ),
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Item'),
                  content: Text('Do you want to delete ?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              setState(() {
                removeItem(context, widget.listItems[i]['id']);
              });
            },
          ),
        );
      },
    );
  }
}
