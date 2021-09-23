import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/home_image_widget.dart';
import '../widgets/main_slider.dart';

class HomeScreen extends StatelessWidget {
  static const pageRoute = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: Column(
        children: <Widget>[
          Expanded(
            child: HomeImageWidget(),
          ),
          Expanded(
            child: Center(
              child: Container(
                // margin: const EdgeInsets.only(
                //   top: 20,
                // ),
                child: MainSlider(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
