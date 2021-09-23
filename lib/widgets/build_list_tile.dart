import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BuildTileList extends StatelessWidget {
  final IconData displayIcon;
  final String tileText;
  final Function callBackHandler;

  BuildTileList({this.displayIcon, this.tileText, this.callBackHandler});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        displayIcon,
        size: 26,
      ),
      title: Text(
        tileText,
        style: Theme.of(context).textTheme.headline3,
      ),
      onTap: () {
        callBackHandler();
      },
    );
  }
}
