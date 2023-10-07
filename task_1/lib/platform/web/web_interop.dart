@JS('ClicksNamespace')
library interop;

import 'dart:ui' as ui;
import 'dart:async';
import 'package:js/js.dart';

@JS('JsInteropEvent')
class _JsInteropEvent {
  external int value;
}

@JS('JsInteropEventType')
class EventType {
  // ignore: non_constant_identifier_names
  external static String get InteropEvent;
}

typedef _ClicksManagerEventListener = void Function(_JsInteropEvent event);

@JS('JsInteropManager')
class _JsInteropManager {
  external Object get buttonElement;
  external void setTextToJsButton(String text);
  external void addEventListener(
      String event, _ClicksManagerEventListener listener);
  external void removeEventListener(
      String event, _ClicksManagerEventListener listener);
}

class _EventStreamProvider {
  final _JsInteropManager _eventTarget;
  final List<StreamController<dynamic>> _controllers = [];

  _EventStreamProvider.forTarget(this._eventTarget);

  Stream<T> forEvent<T extends _JsInteropEvent>(String eventType) {
    late StreamController<T> controller;
    void onEventReceived(event) {
      controller.add(event as T);
    }

    final interopted = allowInterop(onEventReceived);

    controller = StreamController.broadcast(
      onCancel: () => _eventTarget.removeEventListener(eventType, interopted),
      onListen: () => _eventTarget.addEventListener(eventType, interopted),
    );

    _controllers.add(controller);
    return controller.stream;
  }

  void dispose() {
    // ignore: avoid_function_literals_in_foreach_calls
    _controllers.forEach((controller) => controller.close());
  }
}

class InteropManager {
  final _interop = _JsInteropManager();

  late Stream<int> _buttonClicked;

  InteropManager() {
    final streamProvider = _EventStreamProvider.forTarget(_interop);
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'web-button',
      (viewId) {
        return _interop.buttonElement;
      },
    );
    _buttonClicked = streamProvider
        .forEvent<_JsInteropEvent>('InteropEvent')
        .map((event) => event.value);
  }

  void setTextToJsButton(String text) => _interop.setTextToJsButton(text);

  Stream<int> get buttonClicked => _buttonClicked;
}
