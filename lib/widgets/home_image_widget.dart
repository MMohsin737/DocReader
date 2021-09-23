import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        Container(
          height: mediaQuery.size.height / 3,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Center(
          // margin: EdgeInsets.only(
          //   top: 15,
          // ),
          // padding: EdgeInsets.only(
          //   left: mediaQuery.size.width / 7,
          //   right: mediaQuery.size.width / 7,
          // ),
          child: Image.asset('assets/images/home.png'),
        ),
      ],
    );
  }
}
