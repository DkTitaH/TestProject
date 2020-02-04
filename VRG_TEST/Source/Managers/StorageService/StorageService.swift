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
    func deleteArticle(by id: Int)
    func deleteAllArticles() -> Bool
}

class CoreDataStorageService: StorageService {
    
    enum Entity: String {
        case article = "Article"
    }

    private let persistentContainer: NSPersistentContainer
    private let managedContext: NSManagedObjectContext
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.managedContext = persistentContainer.viewContext
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
        return  self.fetch(entityName: .article).compactMap(self.articleModel)
    }
    
    func deleteArticle(by id: Int) {
        self.delete(entity: .article, predicateFilter: "id == %@", value: id)
    }
    
    func deleteAllArticles() -> Bool {
        return self.delete(entity: .article)
    }
    
    private func articleModel(from article: Article) -> ArticleModelType? {
        return article.id != 0 ? DefaultArticleModel(
            adxKeywords: article.adxKeywords ?? "",
            abstract: article.abstract ?? "",
            id: Int(article.id),
            count: Int(article.count),
            source: article.source ?? "",
            title: article.title ?? "",
            publishedDate: article.publishedDate ?? "",
            countType: article.countType ?? ""
        ) : nil
    }
    
    private func delete(entity: Entity, predicateFilter: String, value: Any) {
        let managedContext = self.managedContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity.rawValue)
        fetchRequest.predicate = NSPredicate(format: predicateFilter, argumentArray: [value])
        
        let object = (try? managedContext.fetch(fetchRequest))?.first
        object.map(managedContext.delete)
        
        try? managedContext.save()
    }
    
    private func delete(entity: Entity) -> Bool {
        let managedContext = self.managedContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        return (try? managedContext.execute(deleteRequest)).map { _ in
            try? managedContext.save()
            
            return true
        } ?? false
    }
    
    private func save<Model>(
        entity: Entity,
        model: Model,
        _ action: @escaping (Model) -> ([String: Any])
    ) {
        let managedContext = self.managedContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let entityValue = NSEntityDescription.entity(forEntityName: entity.rawValue, in: managedContext)!
        let article = NSManagedObject(entity: entityValue, insertInto: managedContext)
        article.setValuesForKeys(action(model))
        
        try? managedContext.save()
    }
    
    private func fetch(entityName: Entity) -> [Article] {
        let managedContext = self.managedContext
        let fetchRequest = NSFetchRequest<Article>(entityName: entityName.rawValue)            
        
        return (try? managedContext.fetch(fetchRequest)) ?? []
    }
}
