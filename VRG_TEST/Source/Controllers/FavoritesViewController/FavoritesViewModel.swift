//
//  FavoritesViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class FavoritesViewModelConfigurator: ConfiguratorType {
    
    let storageService: StorageService
    
    init(storageService: StorageService) {
        self.storageService = storageService
    }
}

enum FavoritesViewEvents: EventsType {
    
    case updateModel
    case showArticleDetailView(ArticleModelType)
    case deleteAll
}

class FavoritesViewModel: ViewModel<FavoritesViewModelConfigurator, FavoritesViewEvents> {
    
    private let storageService: StorageService
    
    let model = BehaviorRelay<[ArticleModelType]>(value: [])
    
    override init(configurator: FavoritesViewModelConfigurator) {
        self.storageService = configurator.storageService
        
        super.init(configurator: configurator)
    }
    
    override func preprareBindings(disposeBag: DisposeBag) {
        self.eventHandler
            .map { $0 }
            .bind { [weak self] in
                self?.handle(events: $0)
            }
            .disposed(by: disposeBag)
    }
    
    override func handle(events: FavoritesViewEvents) {
        switch events {
        case .updateModel:
            self.updateModel()
        case .showArticleDetailView(_):
            break
        case .deleteAll:
            if self.storageService.deleteAllArticles() {
                self.updateModel()
            }
        }
    }
    
    private func updateModel() {
        self.model.accept(self.storageService.fetch())
    }
}
