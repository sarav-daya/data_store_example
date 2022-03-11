// import 'package:data_store_example/loading/loading_screen.dart';
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
      if (isWorking) {
        print('Starting to work');
      } else {
        print('Finishing Work');
      }

      _working = isWorking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading In Page'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Visibility(child: LinearProgressIndicator(), visible: _working),
          AbsorbPointer(
            absorbing: _working,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Center(
                child: MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    _setWorking(true);
                    await Future.delayed(Duration(seconds: 10));
                    _setWorking(false);
                  },
                  // child: _working
                  //     ? Container(
                  //         height: 15,
                  //         width: 15,
                  //         child: CircularProgressIndicator(
                  //           strokeWidth: 1,
                  //           color: Colors.white,
                  //         ),
                  //       )
                  //     : Text('Process'),
                  child: Text('Process'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
