import 'package:flutter_application_pw19/platform/dummy/dummy_service.dart'
    if (dart.library.html) 'package:flutter_application_pw19/platform/web/web_service.dart'
    if (dart.library.io) 'package:flutter_application_pw19/platform/mobile/mobile_service.dart';

abstract class PlatformService {
  void setText(String text);

  Stream<int> getTextLength();
}

PlatformService getServie() {
  return PlatformServiceImpl();
}
