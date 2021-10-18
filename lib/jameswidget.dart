import 'dart:async';
import 'package:flutter/services.dart';

export 'package:jameswidget/firebase/auth/controller/firebase_auth_email_controller.dart';
export 'firebase/auth/widget/signin_btn.dart';
export 'firebase/database/realtime/controller/firebase_realtime_database_controller.dart';
export './design_guide.dart';
export './firebase/firebase_response.dart';

class Jameswidget {
  static const MethodChannel _channel = MethodChannel('jameswidget');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
