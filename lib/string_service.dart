import 'dart:async';

import 'package:flutter/src/services/platform_channel.dart';

class StringService {
  final methodChannel =
      const MethodChannel("com.example.app_name.method_channel.strings");

  final StreamController<String> _stringStreamController =
      StreamController<String>();

  Stream<String> get stringStream => _stringStreamController.stream;

  StringService() {
    // Set method call handler before telling platform side we are ready to receive.
    methodChannel.setMethodCallHandler((call) async {
      print('Just received ${call.method} from platform');
      if (call.method == "new_string") {
        _stringStreamController.add(call.arguments as String);
      } else {
        print("Method not implemented: ${call.method}");
      }
    });
    // Tell platform side we are ready!
    methodChannel.invokeMethod("isReady");
  }
}
