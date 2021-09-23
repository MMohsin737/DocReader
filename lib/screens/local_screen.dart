import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_icons/flutter_icons.dart';

import '../widgets/local_file_view.dart';

class LocalScreen extends StatelessWidget {
  static const pageRoute = '/local-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: LocalFileView(),
    );
  }
}
