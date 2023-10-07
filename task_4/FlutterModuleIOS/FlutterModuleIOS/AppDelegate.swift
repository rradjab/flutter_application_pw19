//
//  AppDelegate.swift
//  FlutterModuleIOS
//
//  Created by Ra on 07.10.2023.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine");
    var navigationcontroller: UINavigationController!
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        flutterEngine.run();

        GeneratedPluginRegistrant.register(with: self.flutterEngine);
    
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

