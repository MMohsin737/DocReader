import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowPopUpSaveFile extends StatefulWidget {
  final Function okHandler;

  ShowPopUpSaveFile(this.okHandler);

  @override
  _ShowPopUpSaveFileState createState() => _ShowPopUpSaveFileState();
}

class _ShowPopUpSaveFileState extends State<ShowPopUpSaveFile> {
  var _myController = TextEditingController();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Save File',
        textAlign: TextAlign.center,
      ),
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _myController,
                  decoration: InputDecoration(
                    labelText: 'File Name',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: FlatButton(
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        widget.okHandler(_myController.text);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: FlatButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color.fromRGBO(100, 100, 100, 1),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              // )
            ],
          ),
          // ),
        ],
      ),
    );
  }
}
