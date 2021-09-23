import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../screens/view_list_doc_main.dart';
import '../helpers/file_get_storage.dart';

class LocalFileView extends StatefulWidget {
  LocalFileView();

  @override
  _LocalFileViewState createState() => _LocalFileViewState();
}

class _LocalFileViewState extends State<LocalFileView> {
  final List<String> _directories = [
    'All Documents',
    'Downloads',
    'Documents',
  ];
  final List<Map<String, int>> _fileNumber = [];
  // List<String> _paths = [];

  @override
  void initState() {
    getNumber();
    super.initState();
  }

  void getTotalFiles() async {
    var res = await FileGetStorage.getAllFiles();
    setState(() {
      _fileNumber.add({'All Documents': res.length});
    });
  }

  void getDownloadFiles() async {
    var res = await FileGetStorage.getAllFilesDownloads();
    setState(() {
      _fileNumber.add({'Downloads': res.length});
    });
  }

  void getDocunmentFiles() async {
    var res = await FileGetStorage.getAllFilesDocuments();
    setState(() {
      _fileNumber.add({'Documents': res.length});
    });
  }

  void getNumber() {
    getTotalFiles();
    getDownloadFiles();
    getDocunmentFiles();
  }

  int getFileQuantity(String key) {
    int res = 0;
    _fileNumber.forEach((element) {
      if (element.containsKey(key)) {
        res = element[key];
      }
    });
    return res;
  }

  Future<List<String>> getPaths(String key) async {
    if (key == 'All Documents') {
      return await FileGetStorage.getAllFiles();
    } else if (key == 'Downloads') {
      return await FileGetStorage.getAllFilesDownloads();
    } else if (key == 'Documents') {
      return await FileGetStorage.getAllFilesDocuments();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _directories.length,
      itemBuilder: (context, index) {
        return _fileNumber.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Ionicons.md_folder,
                      size: 60,
                    ),
                    title: Text(
                      _directories[index],
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    subtitle:
                        Text('${getFileQuantity(_directories[index])} Files'),
                    onTap: () async {
                      var docpaths = await getPaths(_directories[index]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ViewListDocMain(
                            docpaths,
                            _directories[index],
                          ),
                        ),
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
    );
  }
}
