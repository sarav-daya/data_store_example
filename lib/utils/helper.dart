import 'package:flutter/services.dart';

class SnackbarHelper {
  factory SnackbarHelper() => _shared;
  static final SnackbarHelper _shared = SnackbarHelper._sharedInstance();
  final MethodChannel channel = MethodChannel('com.auguryapps.toast');
  SnackbarHelper._sharedInstance();

  showSnackbar({required String message, bool isshort = true}) async {
    await channel
        .invokeMethod('showToast', {"message": "$message", "isshort": isshort});
  }
}
