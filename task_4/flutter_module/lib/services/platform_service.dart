import 'package:flutter/services.dart';

class PlatformService {
  static const platformMethod = MethodChannel('PLATFORM_RANDOM_VALUE_METHOD');

  Future<int> getValue() async {
    try {
      return await platformMethod.invokeMethod('RANDOM_VALUE');
    } catch (e) {
      return 0;
    }
  }
}
