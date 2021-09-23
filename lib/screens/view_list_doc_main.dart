import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:admob_flutter/admob_flutter.dart';

import '../helpers/ad_manager_helper.dart';
//import './file_reader_screen.dart';
import '../providers/save_data.dart';
import '../widgets/file_viewer.dart';

class ViewListDocMain extends StatefulWidget {
  static const pageRoute = '/view-list-doc-main';
  final List<String> docPaths;
  final String titleText;

  ViewListDocMain([this.docPaths, this.titleText]);

  @override
  _ViewListDocMainState createState() => _ViewListDocMainState();
}

class _ViewListDocMainState extends State<ViewListDocMain> {
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

  String getIcon(String key) {
    if (key == 'pdf') {
      return 'assets/images/pdf.png';
    } else if (key == 'doc' || key == 'docx') {
      return 'assets/images/word.png';
    } else if (key == 'ppt' || key == 'pptx') {
      return 'assets/images/ppt.png';
    } else if (key == 'xls' || key == 'xlsx') {
      return 'assets/images/xls.png';
    } else {
      return 'assets/images/txt.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        title: Text(widget.titleText),
        centerTitle: true,
      ),
      body: widget.docPaths.length == 0
          ? Center(
              child: Text('No Files Found'),
            )
          : ListView.separated(
              itemCount: widget.docPaths.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        '${getIcon(widget.docPaths[index].split('.').last)}',
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                      title: Text(
                        widget.docPaths[index].split('/').last.split('.').first,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      onTap: () async {
                        await Provider.of<SaveData>(context, listen: false)
                            .addItems(
                          context,
                          {
                            'id': widget.docPaths[index],
                            'docpath': widget.docPaths[index],
                          },
                        );
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
                            // return FlieReaderScreen(widget.docPaths[index]);
                            return WebViewViewer(
                              getPath: widget.docPaths[index],
                            );
                          }),
                        );
                      },
                    ),
                    Divider(
                      indent: 90,
                      color: Color.fromRGBO(57, 57, 57, 0.5),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return (index != 0 && index % 5 == 0)
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: _bannerAd,
                      )
                    : Container();
              },
            ),
    );
  }
}
