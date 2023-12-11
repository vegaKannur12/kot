import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class ExternalDir {
  String? tempFp;
  // ignore: unused_field
  final List<FileSystemEntity> _folders = [];
  fileRead() async {
    // String path;
    Directory? extDir = await getExternalStorageDirectory();
    String dirPath = '${extDir!.path}/VgFp/';
    // ignore: avoid_print
    print("dirPath----$dirPath");
    dirPath =
        dirPath.replaceAll("Android/data/com.example.trafiqpro/files/", "");
    await Directory(dirPath).create(recursive: true);
    final File file = File('$dirPath/fpCode.txt');
    // ignore: avoid_print
    print("file...$file");
    String filpath = '$dirPath/fpCode.txt';
    if (await File(filpath).exists()) {
      // ignore: avoid_print
      print("existgfgf");
      tempFp = await file.readAsString();
      // ignore: avoid_print
      print("file exist----$tempFp");
    } else {
      tempFp = "";
    }
    // ignore: avoid_print
    print("file exist----$tempFp");
    return tempFp;
  }

///////////////////////////////////////////////////////////////////////////////////
  fileWrite(String fp) async {
    // ignore: avoid_print
    print("fpppp====$fp");
    Directory? extDir = await getExternalStorageDirectory();

    String dirPath = '${extDir!.path}/VgFp';
    dirPath =
        dirPath.replaceAll("Android/data/com.example.trafiqpro/files/", "");
    await Directory(dirPath).create(recursive: true);

    // Directory? baseDir = Directory('storage/emulated/0/Android/data');
    final File file = File('$dirPath/fpCode.txt');
    // ignore: avoid_print
    print("file...$file");
    String filpath = '$dirPath/fpCode.txt';
    if (await File(filpath).exists()) {
      // ignore: avoid_print
      print("file exists");
    } else {
      await file.writeAsString(fp);
    }
  }
}
