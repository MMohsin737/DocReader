import 'dart:io';

import 'package:ext_storage/ext_storage.dart';

class FileGetStorage {
  static Future<List<Map<String, int>>> getTotalNumberOfFiles() async {
    List<String> val = [];
    List<Map<String, int>> totalData = [];
    //////////////////////////////////////////////
    val = await FileGetStorage.getAllFiles();
    totalData.add({'All': val.length == 0 ? 0 : val.length});
    /////////////////////////////////////////////
    val = await FileGetStorage.getDocFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getDocFilesDownloadsDirectory());
    totalData.add({'WORD': val.length == 0 ? 0 : val.length});
    /////////////////////////////////////////////
    val = await FileGetStorage.getPDFFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getPDFFilesDownloadsDirectory());
    totalData.add({'PDF': val.length == 0 ? 0 : val.length});
    /////////////////////////////////////////////
    val = await FileGetStorage.getPptFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getPptFilesDownloadsDirectory());
    totalData.add({'PRESENTATION': val.length == 0 ? 0 : val.length});
    /////////////////////////////////////////////
    val = await FileGetStorage.getTextFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getTextFilesDownloadsDirectory());
    totalData.add({'TEXT': val.length == 0 ? 0 : val.length});
    /////////////////////////////////////////////
    val = await FileGetStorage.getXlsFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getXlsFilesDownloadsDirectory());
    totalData.add({'SPREADSHEET': val.length == 0 ? 0 : val.length});
    /////////////////////////////////////////////
    return totalData;
  }

  static Future<List<String>> getAllFiles() async {
    List<String> list1 = await FileGetStorage.getAllFilesDownloads();
    List<String> list2 = [];
    try {
      list2 = await FileGetStorage.getAllFilesDocuments();
    } catch (e) {
      print(e);
    }
    list1.addAll(list2);
    return list1.toList();
  }

  static Future<List<String>> getAllFilesDownloads() async {
    var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS,
    );
    var data = Directory("$pathDownloads").list().where(
          (event) => (event.path.split('.').last == 'pdf' ||
              event.path.split('.').last == 'doc' ||
              event.path.split('.').last == 'docx' ||
              event.path.split('.').last == 'ppt' ||
              event.path.split('.').last == 'pptx' ||
              event.path.split('.').last == 'xls' ||
              event.path.split('.').last == 'xlsx'),
        );
    return await data.map((element) => element.path).toList();
  }

  static Future<List<String>> getAllFilesDocuments() async {
    try {
      var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOCUMENTS,
      );
      var data = Directory("$pathDownloads").list().where(
            (event) => (event.path.split('.').last == 'pdf' ||
                event.path.split('.').last == 'doc' ||
                event.path.split('.').last == 'docx' ||
                event.path.split('.').last == 'ppt' ||
                event.path.split('.').last == 'pptx' ||
                event.path.split('.').last == 'xls' ||
                event.path.split('.').last == 'xlsx'),
          );
      return await data.map((element) => element.path).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List<String>> getAllFilesPDF() async {
    List<String> val = await FileGetStorage.getPDFFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getPDFFilesDownloadsDirectory());
    return val;
  }

  static Future<List<String>> getAllFilesWord() async {
    List<String> val = await FileGetStorage.getDocFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getDocFilesDownloadsDirectory());
    return val;
  }

  static Future<List<String>> getAllFilesPpt() async {
    List<String> val = await FileGetStorage.getPptFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getPptFilesDownloadsDirectory());
    return val;
  }

  static Future<List<String>> getAllFilesXls() async {
    List<String> val = await FileGetStorage.getXlsFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getXlsFilesDownloadsDirectory());
    return val;
  }

  static Future<List<String>> getAllFilesText() async {
    List<String> val = await FileGetStorage.getTextFilesDocumentsDirectory();
    val.addAll(await FileGetStorage.getTextFilesDownloadsDirectory());
    return val;
  }

  ///////////////////////////////////////////////////////
  // Functions to get files from Downloads Directory ////
  ///////////////////////////////////////////////////////
  static Future<List<String>> getPDFFilesDownloadsDirectory() async {
    var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS,
    );
    var data = Directory("$pathDownloads")
        .list()
        .where((event) => event.path.split('.').last == 'pdf');
    return await data.map((element) => element.path).toList();
  }

  static Future<List<String>> getTextFilesDownloadsDirectory() async {
    var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS,
    );
    var data = Directory("$pathDownloads")
        .list()
        .where((event) => event.path.split('.').last == 'txt');
    return await data.map((element) => element.path).toList();
  }

  static Future<List<String>> getDocFilesDownloadsDirectory() async {
    var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS,
    );
    var data = Directory("$pathDownloads").list().where((event) =>
        (event.path.split('.').last == 'doc' ||
            event.path.split('.').last == 'docx'));
    return await data.map((element) => element.path).toList();
  }

  static Future<List<String>> getPptFilesDownloadsDirectory() async {
    var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS,
    );
    var data = Directory("$pathDownloads").list().where((event) =>
        (event.path.split('.').last == 'ppt' ||
            event.path.split('.').last == 'pptx'));
    return await data.map((element) => element.path).toList();
  }

  static Future<List<String>> getXlsFilesDownloadsDirectory() async {
    var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS,
    );
    var data = Directory("$pathDownloads").list().where((event) =>
        (event.path.split('.').last == 'xls' ||
            event.path.split('.').last == 'xlsx'));
    return await data.map((element) => element.path).toList();
  }

  ///////////////////////////////////////////////////////
  // Functions to get files from Documnets Directory ////
  ///////////////////////////////////////////////////////
  static Future<List<String>> getPDFFilesDocumentsDirectory() async {
    try {
      var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOCUMENTS,
      );
      var data = Directory("$pathDownloads")
          .list()
          .where((event) => event.path.split('.').last == 'pdf');
      return await data.map((element) => element.path).toList();
    } catch (e) {
      if (e.toString().contains('No such file or directory')) {
        return [];
      }
    }
    return [];
  }

  static Future<List<String>> getDocFilesDocumentsDirectory() async {
    try {
      var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOCUMENTS,
      );
      var data = Directory("$pathDownloads").list().where((event) =>
          (event.path.split('.').last == 'doc' ||
              event.path.split('.').last == 'docx'));
      return await data.map((element) => element.path).toList();
    } catch (e) {
      if (e.toString().contains('No such file or directory')) {
        return [];
      }
    }
    return [];
  }

  static Future<List<String>> getTextFilesDocumentsDirectory() async {
    try {
      var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOCUMENTS,
      );
      var data = Directory("$pathDownloads")
          .list()
          .where((event) => event.path.split('.').last == 'txt');
      return await data.map((element) => element.path).toList();
    } catch (e) {
      if (e.toString().contains('No such file or directory')) {
        return [];
      }
    }
    return [];
  }

  static Future<List<String>> getPptFilesDocumentsDirectory() async {
    try {
      var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOCUMENTS,
      );
      var data = Directory("$pathDownloads").list().where((event) =>
          (event.path.split('.').last == 'ppt' ||
              event.path.split('.').last == 'pptx'));
      return await data.map((element) => element.path).toList();
    } catch (e) {
      if (e.toString().contains('No such file or directory')) {
        return [];
      }
    }
    return [];
  }

  static Future<List<String>> getXlsFilesDocumentsDirectory() async {
    try {
      var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOCUMENTS,
      );
      var data = Directory("$pathDownloads").list().where((event) =>
          (event.path.split('.').last == 'xls' ||
              event.path.split('.').last == 'xlsx'));
      return await data.map((element) => element.path).toList();
    } catch (e) {
      if (e.toString().contains('No such file or directory')) {
        return [];
      }
    }
    return [];
  }

  //////////////////////////////////////////////////////
  // Functions to get files from Whatsapp Directory ////
  //////////////////////////////////////////////////////
  // static Future<List<String>> getPDFFilesDocumentsDirectory() async {
  //   var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory();
  //   var data = Directory("$pathDownloads")
  //       .list()
  //       .where((event) => event.path.split('.').last == 'pdf');
  //   return await data.map((element) => element.path).toList();
  // }

  // static Future<List<String>> getDocFilesDocumentsDirectory() async {
  //   var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
  //     ExtStorage.DIRECTORY_DOCUMENTS,
  //   );
  //   var data = Directory("$pathDownloads").list().where((event) =>
  //       (event.path.split('.').last == 'doc' ||
  //           event.path.split('.').last == 'docx'));
  //   return await data.map((element) => element.path).toList();
  // }

  // static Future<List<String>> getPptFilesDocumentsDirectory() async {
  //   var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
  //     ExtStorage.DIRECTORY_DOCUMENTS,
  //   );
  //   var data = Directory("$pathDownloads").list().where((event) =>
  //       (event.path.split('.').last == 'ppt' ||
  //           event.path.split('.').last == 'pptx'));
  //   return await data.map((element) => element.path).toList();
  // }

  // static Future<List<String>> getXlsFilesDocumentsDirectory() async {
  //   var pathDownloads = await ExtStorage.getExternalStoragePublicDirectory(
  //     ExtStorage.DIRECTORY_DOCUMENTS,
  //   );
  //   var data = Directory("$pathDownloads").list().where((event) =>
  //       (event.path.split('.').last == 'xls' ||
  //           event.path.split('.').last == 'xlsx'));
  //   return await data.map((element) => element.path).toList();
  // }
}
