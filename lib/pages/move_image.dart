import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:data_store_example/utils/draggable_sizable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';

class MoveImagePage extends StatefulWidget {
  const MoveImagePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MoveImagePage> createState() => _MoveImagePageState();
}

class _MoveImagePageState extends State<MoveImagePage> {
  bool _itemSelected = true;
  final GlobalKey _repaintKey = GlobalKey();

  XFile? image;

  void _saveImage() async {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final path = (await getTemporaryDirectory()).path +
          "screenshot${DateTime.now().toIso8601String()}.png";
      File imgFile = File(path);
      await imgFile.writeAsBytes(pngBytes);
      ImageGallerySaver.saveFile(imgFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File saved'),
        ),
      );
    }
  }

  Uint8List pngBytes = Uint8List(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 3));
      final bytes =
          (await rootBundle.load('assets/dash.png')).buffer.asUint8List();
      setState(() {
        pngBytes = bytes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final _image =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (_image != null) {
                setState(() {
                  image = _image;
                });
              }
            },
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: () async {
              if (await SuperEasyPermissions.isGranted(Permissions.storage)) {
                _saveImage();
              } else if (await SuperEasyPermissions.askPermission(
                Permissions.storage,
              )) {
                _saveImage();
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Access to storage is required'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: RepaintBoundary(
          key: _repaintKey,
          child: Stack(
            // fit: StackFit.expand,
            children: [
              Center(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: image != null
                          ? Image.file(File(image!.path))
                          : Container(),
                    ),
                    Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            key: const Key(
                                'stickersView_background_gestureDetector'),
                            onTap: () {
                              setState(() {
                                _itemSelected = false;
                              });
                            },
                          ),
                        ),
                        DraggableResizable(
                          onUpdate: (value) {
                            if (!_itemSelected)
                              setState(
                                () {
                                  _itemSelected = true;
                                },
                              );
                          },
                          canTransform: _itemSelected,
                          size: Size(50, 50),
                          constraints: BoxConstraints(
                            minHeight: 40,
                            minWidth: 40,
                            maxHeight: 200,
                            maxWidth: 200,
                          ),
                          child: SizedBox(
                            child: pngBytes.isEmpty
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: Colors.black,
                                    ),
                                  )
                                : Image.memory(pngBytes),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
