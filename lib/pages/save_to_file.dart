import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';

class SaveToFilePage extends StatefulWidget {
  const SaveToFilePage({Key? key}) : super(key: key);

  @override
  State<SaveToFilePage> createState() => _SaveToFilePageState();
}

class _SaveToFilePageState extends State<SaveToFilePage> {
  GlobalKey _globalKey = new GlobalKey();
  late Uint8List bytes = Uint8List(0);
  int counter = 0;

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    String dir = (await getApplicationDocumentsDirectory()).path;
    String fullPath = '$dir/abc.png';
    print("local file full path ${fullPath}");
    File file = File(fullPath);
    await file.writeAsBytes(pngBytes);
    print(file.path);

    bool _permission =
        await SuperEasyPermissions.isGranted(Permissions.storage);

    if (_permission) {
      //final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100);
      final res = await ImageGallerySaver.saveFile(
        file.path,
      );
      print(res);
      print(file.path);
      //print(result);
    } else {
      bool _p = await SuperEasyPermissions.askPermission(Permissions.storage);
      if (_p) {
        final result =
            await ImageGallerySaver.saveImage(pngBytes, quality: 100);
        print(file.path);
        print(result);
      } else {
        // Permission denied, do something else
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Access to storage is required'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          ),
        );
      }
    }
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save to File'),
      ),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Hi - $counter',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    counter++;
                  });
                  var _bytes = await _capturePng();
                  setState(() {
                    bytes = _bytes;
                  });
                },
                child: Text('Save'),
              ),
              SizedBox(
                height: 20.0,
              ),
              bytes.length > 0 ? Image.memory(bytes) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
