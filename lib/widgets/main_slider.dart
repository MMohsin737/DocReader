import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:admob_flutter/admob_flutter.dart';

import '../screens/view_list_doc_main.dart';
import '../helpers/ad_manager_helper.dart';

import '../helpers/file_get_storage.dart';

class MainSlider extends StatefulWidget {
  // final double heightView;
  @override
  _MainSliderState createState() => _MainSliderState();
}

class _MainSliderState extends State<MainSlider> {
  // int _totalFiles;
  AdmobInterstitial _interstitialAd;
//  bool _interstitialAdFlag = false;

  List<String> _docIcons = [
    'assets/images/all.png',
    'assets/images/pdf.png',
    'assets/images/ppt.png',
    'assets/images/txt.png',
    'assets/images/word.png',
    'assets/images/xls.png',
  ];

  List<String> _docIconNames = [
    'All',
    'PDF',
    'PRESENTATION',
    'TEXT',
    'WORD',
    'SPREADSHEET',
  ];

  List<Map<String, int>> _totalNumberFiles = [];

  @override
  void initState() {
    getTotalFiles();
    Admob.initialize(AdManager.appId);
    loadAd();
    super.initState();
  }

  void getTotalFiles() async {
    var res = await FileGetStorage.getTotalNumberOfFiles();
    setState(() {
      _totalNumberFiles = res.toList();
    });
  }

  void loadAd() {
    _interstitialAd = AdManager.getInterstialAd();
    _interstitialAd.load();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  int getNumberOfFiles(String val) {
    int res = 0;
    _totalNumberFiles.forEach(
      (element) {
        if (element.containsKey(val)) {
          res = element[val];
        }
      },
    );
    return res;
  }

  Future<List<String>> getPaths(String key) async {
    if (key == 'All') {
      return await FileGetStorage.getAllFiles();
    } else if (key == 'PDF') {
      return await FileGetStorage.getAllFilesPDF();
    } else if (key == 'PRESENTATION') {
      return await FileGetStorage.getAllFilesPpt();
    } else if (key == 'TEXT') {
      return await FileGetStorage.getAllFilesText();
    } else if (key == 'WORD') {
      return await FileGetStorage.getAllFilesWord();
    } else if (key == 'SPREADSHEET') {
      return await FileGetStorage.getAllFilesXls();
    } else
      return [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          print('index: $index');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Image.asset(
                  _docIcons[index],
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
                onTap: () async {
                  var docpaths = await getPaths(_docIconNames[index]);
                  if (_docIconNames[index] == 'PDF' ||
                      _docIconNames[index] == 'TEXT' ||
                      _docIconNames[index] == 'SPREADSHEET') {
                    _interstitialAd.isLoaded.then((value) {
                      if (value) {
                        _interstitialAd.show();
                        loadAd();
                      }
                    });
                    // loadAd();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ViewListDocMain(
                        docpaths,
                        _docIconNames[index],
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: Text(
                  _docIconNames[index],
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Center(
                child: Text('(${getNumberOfFiles(_docIconNames[index])})'),
              ),
            ],
          );
        },
        itemCount: 6,
        viewportFraction: 0.5,
        scale: 0.2,
      ),
    );
  }
}
