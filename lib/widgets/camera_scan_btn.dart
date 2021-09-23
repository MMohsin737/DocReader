import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CameraScanBtn extends StatelessWidget {
  final Function callBackHandler;

  CameraScanBtn(this.callBackHandler);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ClipOval(
          child: Material(
            color: Theme.of(context).accentColor,
            child: InkWell(
              onTap: callBackHandler,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Icon(
                  Icons.scanner,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
