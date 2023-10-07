import Flutter
import UIKit


var _eventSink: FlutterEventSink!

extension AppDelegate: FlutterStreamHandler {


    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _eventSink = nil
        return nil
    }
}


class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

   public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    let button = UIButton()
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _view = UIView()
        super.init()
        createNativeView(view: _view, binaryMessenger: messenger, arguments: args)
    }

    func view() -> UIView {
        return _view
    }

    @objc
    func onClick(sender: UIButton!) {
        _eventSink(button.currentTitle?.count)
    }

    func createNativeView(view _view: UIView, binaryMessenger messenger: FlutterBinaryMessenger, arguments args: Any?){
        
        let channel = FlutterMethodChannel(name: "BUTTON_TEXT_METHOD", binaryMessenger: messenger)
        var initialText = ""
        if let args = args as? Dictionary<String, Any>,
           let textValue = args["initialText"] as? String {
                initialText = textValue
                debugPrint(textValue)
            } else {
                debugPrint("Else")
            }

        button.setTitle(initialText, for: .normal)
        button.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
        button.backgroundColor = UIColor.blue
        button.frame = CGRect(x: 0, y: 0, width: 220, height: 48.0)
        _view.addSubview(button)

        

        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "BUTTON_TEXT" else {
                
                result(FlutterMethodNotImplemented)
                return
            }
            var _arguments = call.arguments as? [String: Any]
            let text = _arguments?["text"] as? String
            self.button.setTitle(text!, for: .normal)
            result(Int.random(in: 0..<500))
        })
    }
}
