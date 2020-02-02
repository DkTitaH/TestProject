//
//  MostSharedViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MostSharedViewModelConfigurator: ConfiguratorType {
 
    let requestService: APIService
    
    init(requestService: APIService) {
        self.requestService = requestService
    }
}

enum MostSharedViewEvents: EventsType {
    case getSharedModel
    case showSharedArticleDetailView(SharedArticleModel)
}


class MostSharedViewModel: ViewModel<MostSharedViewModelConfigurator, MostSharedViewEvents> {
        
        private let requestService: APIService
        
        let sharedModel = BehaviorRelay<SharedModel>(value: .empty)
        
        override init(configurator: MostSharedViewModelConfigurator) {
            self.requestService = configurator.requestService
            
            super.init(configurator: configurator)
            
            self.preprareBindings()
        }
        
        func preprareBindings() {
            self.eventHandler
                .map { $0 }
                .bind { [weak self] in
                    self?.handle(events: $0)
                }
                .disposed(by: self.disposeBag)
        }
        
        override func handle(events: MostSharedViewEvents) {
            switch events {
            case .getSharedModel:
                self.requestService.getSharedArticles { result in
                    switch result {
                    case let .success(model):
                        self.sharedModel.accept(model)
                    case let .failure(error):
                        print(error)
                    }
                }
            case let .showSharedArticleDetailView(model):
                break
                //            self.internalEventHandler.onNext(<#T##element: MostEmailedViewInputEvent##MostEmailedViewInputEvent#>)
            }
        }
}

