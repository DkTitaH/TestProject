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

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VRG_TEST")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

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
        let storageService = CoreDataStorageService(persistentContainer: self.persistentContainer)
        
        return AppFlowController(requestService: requestService, storageService: storageService)
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

//    var articles: [NSManagedObject] = []
    
//    func save(model: ArticleModelType) {
//        // 1
//        let managedContext = self.persistentContainer.viewContext
//
//        // 2
//        let entity = NSEntityDescription.entity(forEntityName: "Article",
//                                       in: managedContext)!
//
//        let article = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//
//        article.setValuesForKeys(
//            [
//                "abstracrt": model.abstract,
//                "adxKeywords": model.adxKeywords,
//                "count": model.count,
//                "countType": model.countType,
//                "source": model.source,
//                "publishedDate": model.publishedDate,
//                "id": model.id
//
//            ]
//        )
//
//        do {
//            try managedContext.save()
//            articles.append(article)
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
    
}
