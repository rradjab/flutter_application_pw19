import 'package:flutter/services.dart';
import 'package:flutter_application_pw19/platform/platform_service.dart';

class PlatformServiceImpl extends PlatformService {
  static const platform = MethodChannel('BUTTON_TEXT_METHOD');
  static const stream = EventChannel('BUTTON_TEXT_LENGTH_EVENT');

  @override
  Future<String> setText(String text) async {
    try {
      return await platform.invokeMethod('BUTTON_TEXT', {"text": text});
    } catch (e) {
      return 'something wrong: $e';
    }
  }

  @override
  Stream<int> getTextLength() =>
      stream.receiveBroadcastStream().map((event) => event as int);
}
