import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
) -> Bool {

    var registrar = self.registrar(forPlugin: "integration-test")
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

    let eventChannel = FlutterEventChannel(name: "BUTTON_TEXT_LENGTH_EVENT", binaryMessenger: controller.binaryMessenger)

    eventChannel.setStreamHandler(self)

    let factory = FLNativeViewFactory(messenger: registrar!.messenger())
    self.registrar(forPlugin: "<integration-test>")!.register(
        factory,
        withId: "INTEGRATION_I0S")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
