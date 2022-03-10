import 'dart:io';

import 'package:data_store_example/pages/detail_folder.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DetailsFolderPage extends StatefulWidget {
  @override
  _DetailsFolderPageState createState() => _DetailsFolderPageState();
}

class _DetailsFolderPageState extends State<DetailsFolderPage> {
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

  callFolderCreationMethod(String folderInAppDocDir) async {
    // ignore: unused_local_variable
    String actualFileName = await createFolderInAppDocDir(folderInAppDocDir);
    print(actualFileName);
    setState(() {});
  }

  final folderController = TextEditingController();
  String nameOfFolder = 'docs';
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                'ADD FOLDER',
                textAlign: TextAlign.left,
              ),
              Text(
                'Type a folder name to add',
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return TextField(
                controller: folderController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Enter folder name'),
                onChanged: (val) {
                  setState(() {
                    nameOfFolder = folderController.text;
                    print(nameOfFolder);
                  });
                },
              );
            },
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await callFolderCreationMethod(nameOfFolder);
                getDir();
                setState(() {
                  folderController.clear();
                  nameOfFolder = "";
                });
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Colors.redAccent,
              child: Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<FileSystemEntity> _folders = [];

  Future<void> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/';
    final myDir = new Directory(pdfDirectory);
    setState(() {
      _folders = myDir.listSync(recursive: true, followLinks: false);
    });
    print(_folders);
  }

  Future<void> _showDeleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure to delete this folder?',
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Yes'),
              onPressed: () async {
                await _folders[index].delete();
                getDir();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _folders = [];
    getDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Folder Info"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showMyDialog();
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return Material(
            elevation: 1.0,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                          future: getFileType(_folders[index]),
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData) {
                              FileStat f = snapshot.data as FileStat;
                              print("file.stat() ${f.type}");
                              ;
                              if (f.type.toString().contains("file")) {
                                return Icon(
                                  Icons.file_copy_outlined,
                                  size: 40,
                                  color: Colors.orange,
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (builder) {
                                      return InnerFolder(
                                          filespath: _folders[index].path);
                                    }));
                                    /* final myDir = new Directory(_folders[index].path);

                                          var    _folders_list = myDir.listSync(recursive: true, followLinks: false);

                                          for(int k=0;k<_folders_list.length;k++)
                                          {
                                            var config = File(_folders_list[k].path);
                                            print("IsFile ${config is File}");
                                          }
                                          print(_folders_list);*/
                                  },
                                  child: Icon(
                                    Icons.folder,
                                    size: 40,
                                    color: Colors.orange,
                                  ),
                                );
                              }
                            }
                            return Icon(
                              Icons.file_copy_outlined,
                              size: 40,
                              color: Colors.orange,
                            );
                          }),
                      Text(
                        '${_folders[index].path.split('/').last}',
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      _showDeleteDialog(index);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: _folders.length,
      ),
    );
  }

  Future getFileType(file) {
    return file.stat();
  }
}
