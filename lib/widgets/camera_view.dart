import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

//import '../screens/image_scan_screen.dart';
//import '../screens/scan_screen.dart';
import '../helpers/image_helpers.dart';
import '../providers/save_data.dart';
import './image_scanner_animation.dart';
import './camera_scan_btn.dart';

class CamerViewWidget extends StatefulWidget {
  static const routePage = '/camera-view-widget';
  @override
  _CamerViewWidgetState createState() => _CamerViewWidgetState();
}

class _CamerViewWidgetState extends State<CamerViewWidget>
    with SingleTickerProviderStateMixin {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;
  String val;

  AnimationController animationController;
  bool animationStopped = false;
  bool showBar = false;

  @override
  void initState() {
    super.initState();
    animationInit(this);
    setupCameras();
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  void animationInit(TickerProvider tickerProvider) {
    animationController = new AnimationController(
      duration: new Duration(seconds: 1),
      vsync: tickerProvider,
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      animationController.reverse(from: 1.0);
    } else {
      animationController.forward(from: 0.0);
    }
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize().whenComplete(() {
        if (controller.value.isInitialized) {
          setState(() {
            isReady = true;
          });
        }
      });
    } on CameraException catch (_) {
      Navigator.pop(context);
    }
  }

  void storeFile() async {
    val = await ImageHelpers.captureImageCamera(controller);
  }

  void startAnimation() {
    storeFile();
    setState(() {
      showBar = !showBar;
    });
    setState(() {
      animationStopped = false;
    });
    animateScanAnimation(animationStopped);
    new Timer(
      Duration(seconds: 2),
      () {
        setState(() {
          animationStopped = true;
        });

        Provider.of<SaveData>(context, listen: false).saveImagePath(val);
        Navigator.pop(context);
      },
    );
  }

  Future<bool> moveBack() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: moveBack,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: (!isReady || !controller.value.isInitialized)
                  ? Container()
                  : CameraPreview(controller),
            ),
            if (showBar)
              ImageScannerAnimation(
                animationStopped,
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
                animation: animationController,
              ),
            CameraScanBtn(startAnimation),
          ],
        ),
      ),
    );
  }
}

mixin ImageValueNotifier {}
