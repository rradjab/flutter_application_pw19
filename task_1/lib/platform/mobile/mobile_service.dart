import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_pw19/platform/platform_service.dart';

class PlatformServiceImpl extends PlatformService {
  static const platform = MethodChannel('BUTTON_TEXT_METHOD');
  static const stream = EventChannel('BUTTON_TEXT_LENGTH_EVENT');

  @override
  void setText(String text) {
    try {
      platform.invokeMethod('BUTTON_TEXT', {"text": text});
    } catch (e) {
      debugPrint('something wrong: $e');
    }
  }

  @override
  Stream<int> getTextLength() =>
      stream.receiveBroadcastStream().map((event) => event as int);
}
