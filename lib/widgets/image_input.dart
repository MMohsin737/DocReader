import 'dart:io';
// import 'dart:ui' as ui;
// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:bitmap/bitmap.dart';
// import 'package:bitmap/transformations.dart' as bmp;

// import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final List<String> imagePath;

  ImageInput(this.imagePath);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Widget _showImageContainer() {
    return (widget.imagePath == null || widget.imagePath.length == 0)
        ? Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Text(
                'No Image Taken',
                style: TextStyle(
                  color: Color.fromRGBO(235, 235, 235, 0.5),
                ),
              ),
            ),
          )
        : Swiper(
            itemCount: widget.imagePath.length,
            loop: false,
            itemBuilder: (ctx, i) {
              // reTouchImage(widget.imagePath[i]);
              return Image.file(
                File(widget.imagePath[i]),
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.hardLight,
                filterQuality: FilterQuality.high,
              );
            },
            pagination: SwiperPagination(),
          );
  }

  @override
  Widget build(BuildContext context) {
    print('ValuesInsideImagePath: ${widget.imagePath}');
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(68, 68, 68, 1),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Color.fromRGBO(189, 183, 171, 1)),
      ),
      child: _showImageContainer(),
    );
  }
}

mixin Uint8List {}
