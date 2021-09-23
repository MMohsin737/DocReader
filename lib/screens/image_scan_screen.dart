import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/image_input.dart';
import '../widgets/camera_view.dart';
import '../providers/save_data.dart';
import '../widgets/scaned_file_preview_btn.dart';
import '../widgets/show_pop_up_save_file.dart';

import '../helpers/pdf_creator_helper.dart';

class ImageScanScreen extends StatefulWidget {
  static const pageRoute = '/image-scan-screen';

  @override
  _ImageScanScreenState createState() => _ImageScanScreenState();
}

class _ImageScanScreenState extends State<ImageScanScreen> {
  List<String> _storedImage = [];
  String fileName = '';

  void openCam() async {
    String val;
    await Navigator.pushNamed(context, CamerViewWidget.routePage);
    // _storedImage.add(val.toString());
    val = Provider.of<SaveData>(context, listen: false).getImagePath();
    if (val != '') {
      setState(() {
        _storedImage.add(val);
        Provider.of<SaveData>(context, listen: false).saveImagePath('');
      });
    }
  }

  // ignore: missing_return
  Future<void> displayAlertDilogCancel(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Item'),
        content: _storedImage.length == 0
            ? Text('Are you sure?')
            : Text('Are you sure?\nAll images will be deleted!'),
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
    ).then((value) {
      if (value) {
        Provider.of<SaveData>(context, listen: false).saveImagePath('');
        Navigator.pop(context);
      }
    });
  }

  void _setNameFile(String value) {
    fileName = value;
  }

  void saveData() async {
    await showDialog(
      context: context,
      builder: (context) => ShowPopUpSaveFile(_setNameFile),
      // child: Container(),
    ).whenComplete(() async {
      if (fileName != null && fileName != '') {
        await PdfCreatorHelper.generatePDF(
          context,
          _storedImage,
          fileName,
        );
        _showToastRes(context, message: '$fileName > Downloads');
      } else {
        _showToastRes(context, message: 'Please Enter File Name');
      }
      Navigator.pop(context);
    });
  }

  void _showToastRes(BuildContext ctx, {String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Theme.of(ctx).primaryColor,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
  }

  void onNullOk(BuildContext ctx) {
    _showToastRes(ctx, message: 'No File To Save!');
  }

  void onNotNullOk(BuildContext ctx) {
    _showToastRes(ctx, message: 'File Saved > Downloads');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => displayAlertDilogCancel(context),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        appBar: AppBar(
          title: Text('Scan File Preview'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: openCam,
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: ImageInput(
                  _storedImage.length == 0 ? null : _storedImage,
                ),
              ),
              Expanded(
                child: ScanedFilePreviewBtn(
                  _storedImage.length == 0 ? () => onNullOk(context) : saveData,
                  () => displayAlertDilogCancel(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
