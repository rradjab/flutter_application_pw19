import 'package:flutter_application_pw19/platform/platform_service.dart';
import 'package:flutter_application_pw19/platform/web/web_interop.dart';

class PlatformServiceImpl extends PlatformService {
  final _manager = InteropManager();

  @override
  void setText(String text) async {
    _manager.setTextToJsButton(text);
  }

  @override
  Stream<int> getTextLength() => _manager.buttonClicked;
}
