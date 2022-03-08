import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/listeners.dart';

class AndroidPlatformPage extends StatefulWidget {
  const AndroidPlatformPage({Key? key}) : super(key: key);

  @override
  State<AndroidPlatformPage> createState() => _AndroidPlatformPageState();
}

class _AndroidPlatformPageState extends State<AndroidPlatformPage> {
  MethodChannel channel = MethodChannel('com.auguryapps.toast');
  List<double> sensorValues = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      eventData!.listen((event) {
        setState(() {
          sensorValues = <double>[event.x, event.y, event.z];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double angle = atan2(sensorValues[1], sensorValues[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Android Platform Code'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Angle : $angle'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                bool res = await channel
                    .invokeMethod('showToast', {"message": "New Message"});
                print(res);
              },
              child: Text('Show'),
            ),
          ],
        ),
      ),
    );
  }
}
