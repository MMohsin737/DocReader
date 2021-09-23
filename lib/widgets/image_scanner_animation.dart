import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double widgetWidth;
  final double widgetHeight;

  ImageScannerAnimation(this.stopped, this.widgetWidth, this.widgetHeight,
      {Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final scorePosition = (animation.value * (widgetHeight - 110));

    Color color1 = Theme.of(context).primaryColor.withOpacity(0.8);
    Color color2 = Theme.of(context).accentColor.withOpacity(0.2);

    if (animation.status == AnimationStatus.reverse) {
      color1 = Theme.of(context).accentColor.withOpacity(0.8);
      color2 = Theme.of(context).primaryColor.withOpacity(0.2);
    }

    return new Positioned(
      bottom: scorePosition,
      child: new Opacity(
        opacity: (stopped) ? 0.0 : 1.0,
        child: Container(
          height: 100,
          width: widgetWidth,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: [color1, color2],
            ),
          ),
        ),
      ),
    );
  }
}
