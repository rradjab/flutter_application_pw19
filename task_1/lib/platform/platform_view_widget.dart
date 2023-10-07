import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class PlatformWidget extends StatelessWidget {
  final String text;
  const PlatformWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    late final Widget view;
    if (kIsWeb) {
      view = HtmlElementView(
        key: UniqueKey(),
        viewType: 'web-button',
        onPlatformViewCreated: (id) => debugPrint('id is - ${id.toString()}'),
      );
    } else if (Platform.isIOS) {
      view = UiKitView(
        viewType: 'INTEGRATION_I0S',
        creationParams: {'initialText': text},
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: (id) => debugPrint('id is - ${id.toString()}'),
      );
    } else if (Platform.isAndroid) {
      view = PlatformViewLink(
        viewType: 'INTEGRATION_ANDROID',
        surfaceFactory: (
          BuildContext context,
          PlatformViewController controller,
        ) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (PlatformViewCreationParams params) {
          final ExpensiveAndroidViewController controller =
              PlatformViewsService.initExpensiveAndroidView(
            id: params.id,
            viewType: params.viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: {'initialText': text},
            creationParamsCodec: const StandardMessageCodec(),
          );
          controller
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();

          return controller;
        },
      );
    } else {
      view = const Text('Unsupported platform for this app');
    }
    return view;
  }
}
