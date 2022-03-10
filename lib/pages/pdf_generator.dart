import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFGeneratorPage extends StatefulWidget {
  const PDFGeneratorPage({Key? key}) : super(key: key);

  @override
  State<PDFGeneratorPage> createState() => _PDFGeneratorPageState();
}

class _PDFGeneratorPageState extends State<PDFGeneratorPage> {
  final pdf = pw.Document();

  _savePdf() async {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    var dir =
        (await getExternalStorageDirectories(type: StorageDirectory.documents))
            ?.first;
    var fullpath = "${dir!.path}/example.pdf";
    print(fullpath);
    final file = File(fullpath);

    file.writeAsBytes(await pdf.save());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Saved in $fullpath')));
  }

  Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory

    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  // List<FileSystemEntity> _folders;
  // Future<void> getDir() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final dir = directory.path;
  //   String pdfDirectory = '$dir/';
  //   final myDir = new Directory(pdfDirectory);
  //   setState(() {
  //     _folders = myDir.listSync(recursive: true, followLinks: false);
  //   });
  //   print(_folders);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter PDF'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _savePdf,
          )
        ],
      ),
      body: Container(),
    );
  }
}
