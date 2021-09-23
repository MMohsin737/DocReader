import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helpers/db_helpers.dart';

class SaveData with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];
  String _imagePath;

  void saveImagePath(String value) {
    _imagePath = value;
  }

  String getImagePath() {
    if (_imagePath != '' && _imagePath != null) {
      return _imagePath;
    } else {
      return '';
    }
  }

  List<Map<String, dynamic>> get items {
    return [..._items];
  }

  bool checkValueExists(Map<String, String> inputData) {
    bool resValue = false;
    for (var val in _items) {
      if (val['id'] == inputData['id']) {
        resValue = true;
      }
    }
    return resValue;
  }

  Future<void> addItems(BuildContext ctx, Map<String, String> inData) async {
    if (!checkValueExists(inData)) {
      int resDBinsert = await DBHelper.insert(
        table: 'recent_docs',
        data: {
          'id': inData['id'],
          'docpath': inData['docpath'],
        },
      );
      if (resDBinsert != 0) {
        _items.add(
          {
            'id': inData['id'],
            'docpath': inData['docpath'],
          },
        );
      }
      notifyListeners();
    } else {
      bringToTop(inData);
    }
  }

  Future<void> fetchAndSetPlaces() async {
    DBHelper.getData('recent_docs')
        .then((value) => print('DataInsideDB: ${value.toList()}'));
    var val = await DBHelper.getData('recent_docs');
    _items = val.map((e) => e).toList();
    notifyListeners();
  }

  Future<void> bringToTop(Map<String, dynamic> value) async {
    var val = value;
    int res = await deleteItem(val['id']);
    if (res == 1) {
      int resDBinsert = await DBHelper.insert(
        table: 'recent_docs',
        data: {
          'id': val['id'],
          'docpath': val['docpath'],
        },
      );
      if (resDBinsert != 0) {
        _items.add(
          {
            'id': val['id'],
            'docpath': val['docpath'],
          },
        );
      }
    }
    notifyListeners();
  }

  Future<int> deleteItem(String idData) async {
    int res = await DBHelper.removeItem(
      table: 'recent_docs',
      id: idData,
    );
    print('db Res: $res');
    if (res == 1) {
      _items = await DBHelper.getData('recent_docs');
      notifyListeners();
    }
    print('_items: $_items');
    return res;
  }
}
