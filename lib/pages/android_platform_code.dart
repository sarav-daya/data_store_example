import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidPlatformPage extends StatefulWidget {
  const AndroidPlatformPage({Key? key}) : super(key: key);

  @override
  State<AndroidPlatformPage> createState() => _AndroidPlatformPageState();
}

class _AndroidPlatformPageState extends State<AndroidPlatformPage> {
  
  MethodChannel channel = MethodChannel('com.auguryapps.toast');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Android Platform Code'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool res = await channel.invokeMethod('showToast', {"message":"New Message"});
            print(res);
          },
          child: Text('Show'),
        ),
      ),
    );
  }
}
