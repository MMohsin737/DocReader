import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandelApp {
  static void _showDialogInfo(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text('Permission Required'),
        content:
            Text('Go to Settings > App Settings > Doc_Reader > Permissions.'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  static Future<bool> getPermissions(BuildContext ctx) async {
    bool res = false;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();
    statuses.map(
      (key, value) {
        value.isGranted ? res = true : res = false;
        if (value.isPermanentlyDenied) {
          _showDialogInfo(ctx);
        }
        return;
      },
    );
    return res;
  }
}
