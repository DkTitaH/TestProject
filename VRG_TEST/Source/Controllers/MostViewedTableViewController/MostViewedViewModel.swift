
//
//  MostSharedViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MostViewedViewModelConfigurator: ConfiguratorType {
    
    let requestService: APIService
    
    init(requestService: APIService) {
        self.requestService = requestService
    }
}

enum MostViewedViewEvents: EventsType {
    case getViewedModel
    case showViewedArticleDetailView(ViewedArticleModel)
}

class MostViewedViewModel: ViewModel<MostViewedViewModelConfigurator, MostViewedViewEvents> {
    
    private let requestService: APIService
    
    let viewedModel = BehaviorRelay<ViewedModel>(value: .empty)
    
    override init(configurator: MostViewedViewModelConfigurator) {
        self.requestService = configurator.requestService
        
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
    
    override func handle(events: MostViewedViewEvents) {
        switch events {
        case .getViewedModel:
            self.requestService.getViewedArticles { result in
                switch result {
                case let .success(model):
                    self.viewedModel.accept(model)
                case let .failure(error):
                    print(error)
                }
            }
        case let .showViewedArticleDetailView(model):
            break
            //            self.internalEventHandler.onNext(<#T##element: MostEmailedViewInputEvent##MostEmailedViewInputEvent#>)
        }
    }
}
