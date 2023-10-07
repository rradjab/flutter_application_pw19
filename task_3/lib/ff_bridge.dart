import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef SimpleFunction = Int Function(Pointer<Utf8> text);
typedef SimpleFunctionDart = int Function(Pointer<Utf8> text);

class FFIBridge {
  late SimpleFunctionDart _getLength;

  FFIBridge() {
    final dl = Platform.isAndroid
        ? DynamicLibrary.open('libsimple.so')
        : DynamicLibrary.process();
    _getLength =
        dl.lookupFunction<SimpleFunction, SimpleFunctionDart>('getLength');
  }

  int getLength(String text) => _getLength(text.toNativeUtf8());
}
