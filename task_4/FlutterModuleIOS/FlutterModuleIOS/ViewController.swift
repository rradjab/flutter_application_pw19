//
//  ViewController.swift
//  FlutterModuleIOS
//
//  Created by Ra on 07.10.2023.
//

import UIKit
import Flutter

var flutterViewController: FlutterViewController?

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        
        flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        let channel = FlutterMethodChannel(name: "PLATFORM_RANDOM_VALUE_METHOD", binaryMessenger: flutterViewController!.binaryMessenger)
        
        
        
        channel.setMethodCallHandler({
            (call: FlutterMethodCall,  result: @escaping FlutterResult) -> Void in
            guard call.method == "RANDOM_VALUE" else {
                result(FlutterMethodNotImplemented)
                return
            }
            result(Int.random(in: 1..<500))
        })
        
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        button.setTitle("OPEN FLUTTER MODULE", for: UIControl.State.normal)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.backgroundColor = UIColor.blue
        
        
        
       
        
      
        self.view.addSubview(button)
    }
    @objc func showFlutter() {
        present(flutterViewController!, animated: true, completion: nil)
    }
}

