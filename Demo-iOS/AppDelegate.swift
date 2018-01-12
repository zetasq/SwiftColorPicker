//
//  AppDelegate.swift
//  Demo-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainWindow = UIWindow()
        self.window = mainWindow
        
        mainWindow.rootViewController = ViewController()
        mainWindow.makeKeyAndVisible()
        
        return true
    }
    
}

