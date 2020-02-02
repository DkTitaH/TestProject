//
//  MostEmailedVIewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MostEmailedViewModelConfigurator: ConfiguratorType {
    
    let requestService: APIService
    
    init(requestService: APIService) {
        self.requestService = requestService
    }
}

enum MostEmailedViewEvents: EventsType {
    case getEmailedModel
    case showEmailedArticleDetailView(EmailedArticleModel)
}

class MostEmailedViewModel: ViewModel<MostEmailedViewModelConfigurator, MostEmailedViewEvents> {
    
    private let requestService: APIService
    
    let emailedModel = BehaviorRelay<EmailedModel>(value: .empty)
    
    override init(configurator: MostEmailedViewModelConfigurator) {
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
    
    override func handle(events: MostEmailedViewEvents) {
        switch events {
        case .getEmailedModel:
            self.requestService.getEmailedArticles { result in
                switch result {
                case let .success(model):
                    self.emailedModel.accept(model)
                case let .failure(error):
                    print(error)
                }
            }
        case let .showEmailedArticleDetailView(model):
            print(model)
//            self.internalEventHandler.onNext(<#T##element: MostEmailedViewInputEvent##MostEmailedViewInputEvent#>)
        }
    }
}
