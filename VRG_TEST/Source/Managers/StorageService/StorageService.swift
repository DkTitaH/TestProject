//
//  StorageService.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 02.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import CoreData

protocol StorageService {
    
    func save(model: ArticleModelType)
    func fetch() -> [ArticleModelType]
    func deleteAllArticles() -> Bool
}

class CoreDataStorageService: StorageService {
    
    enum Entity: String {
        case article = "Article"
    }

    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func save(model: ArticleModelType) {
        self.save(entity: .article, model: model) { model in
            return [
                "abstract": model.abstract,
                "adxKeywords": model.adxKeywords,
                "count": model.count,
                "countType": model.countType,
                "source": model.source,
                "publishedDate": model.publishedDate,
                "title": model.title,
                "id": model.id
            ]
        }
    }
    
    func fetch() -> [ArticleModelType] {
        return self.fetch(entityName: .article)
            .compactMap(self.articleModel)
    }
    
    func deleteAllArticles() -> Bool {
        return self.delete(entity: .article)
    }
    
    private func articleModel(from object: NSManagedObject) -> ArticleModelType? {
        let abstract = object.value(forKey: "abstract") as? String ?? ""
        let adxKeywords = object.value(forKey: "adxKeywords") as? String ?? ""
        let count = object.value(forKey: "count") as? Int ?? 0
        let countType = object.value(forKey: "countType") as? String ?? ""
        let source = object.value(forKey: "source") as? String ?? ""
        let publishedDate = object.value(forKey: "publishedDate") as? String ?? ""
        let title = object.value(forKey: "title") as? String ?? ""
        let id = object.value(forKey: "id") as? Int ?? 0
        
        return id != 0 ? DefaultArticleModel(
                adxKeywords: adxKeywords,
                abstract: abstract,
                id: id,
                count: count,
                source: source,
                title: title,
                publishedDate: publishedDate,
                countType: countType
        ) : nil
    }
        
    private func delete(entity: Entity) -> Bool {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        return (try? managedContext.execute(deleteRequest)).map { _ in  true } ?? false
    }
    
    private func save<Model>(
        entity: Entity,
        model: Model,
        _ action: @escaping (Model) -> ([String: Any])
    ) {
        let managedContext = self.persistentContainer.viewContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let entityValue = NSEntityDescription.entity(forEntityName: entity.rawValue, in: managedContext)!
        let article = NSManagedObject(entity: entityValue, insertInto: managedContext)

        
        article.setValuesForKeys(action(model))
        
        do {
            try managedContext.save()
        } catch {
            print("saving failed")
        }
    }
    
    private func fetch(entityName: Entity) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName.rawValue)
        let managedContext = self.persistentContainer.viewContext
        
        return (try? managedContext.fetch(fetchRequest)) ?? []
    }
}
