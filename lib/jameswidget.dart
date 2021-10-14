import 'dart:async';
import 'package:flutter/services.dart';

export './firebase/login/signin_btn.dart';
export './design_guide.dart';

class Jameswidget {
  static const MethodChannel _channel = MethodChannel('jameswidget');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
