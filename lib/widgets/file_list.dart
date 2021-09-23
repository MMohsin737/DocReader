import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/save_data.dart';
import './list_view_builder.dart';

class FileList extends StatefulWidget {
  final File docFile;

  FileList([this.docFile]);

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  void addElemnetsInList(BuildContext ctx) {
    setState(() async {
      await Provider.of<SaveData>(context, listen: false).addItems(
        context,
        {
          'id': widget.docFile.path,
          'docpath': widget.docFile.path,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print('docPath: ${widget.docFile}');
    if (widget.docFile != null) {
      addElemnetsInList(context);
    }
    return ListViewBuilder(Provider.of<SaveData>(context, listen: true).items);
  }
}
