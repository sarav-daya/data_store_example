import 'package:data_store_example/loading/loading_screen.dart';
import 'package:flutter/material.dart';

class LoadinInPage extends StatefulWidget {
  const LoadinInPage({Key? key}) : super(key: key);

  @override
  State<LoadinInPage> createState() => _LoadinInPageState();
}

class _LoadinInPageState extends State<LoadinInPage> {
  bool _working = false;
  _setWorking(bool isWorking) {
    setState(() {
      _working = isWorking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading In Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: MaterialButton(
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () async {
              LoadingScreen()
                  .show(context: context, text: 'Loading Please Wait...');
              await Future.delayed(Duration(seconds: 10));
              LoadingScreen().hide();
            },
            child: _working
                ? Container(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Colors.white,
                    ),
                  )
                : Text('Process'),
          ),
        ),
      ),
    );
  }
}
