import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:ext_storage/ext_storage.dart';

class PdfCreatorHelper {
  static Future<void> generatePDF(
    BuildContext context,
    List<String> imagePaths,
    String fileName,
  ) async {
    final pdf = pw.Document();

    if (imagePaths.length > 1) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => imagePaths
              .map(
                (e) => pw.Center(
                  child: pw.Image(
                    PdfImage.file(
                      pdf.document,
                      bytes: File(e).readAsBytesSync(),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    } else {
      final image = PdfImage.file(
        pdf.document,
        bytes: File(imagePaths[0]).readAsBytesSync(),
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            );
          },
        ),
      );
    }

    var pathToSave = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS,
    );
    final file = File('$pathToSave/$fileName.pdf');
    await file.writeAsBytes(pdf.save());
  }
}
