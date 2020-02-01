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
        
        let service = AlamofireAPIService(decoder: .init())
        
        let vc1 = ViewTab(title: "Most Emailed", controller: MostEmailedView(requestService: service))
//        let vc2 = ViewTab(title: "Most Shared", controller: MostEmailedView())
//        let vc3 = ViewTab(title: "Most Viewed", controller: MostEmailedView())
//        let vc4 = ViewTab(title: "Favorites", controller: MostEmailedView())
        
        let children = [vc1]
        
        return ArticlesTabBarViewController(viewTabs: children)
    }
}
