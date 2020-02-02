//
//  AppDelegate.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self.appFlow()
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
    
    func appFlow() -> UIViewController {
        let requestService = AlamofireAPIService(decoder: .init())
        
        return AppFlowController(requestService: requestService)
    }
}
