
//
//  MostSharedViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

class MostViewedViewModelConfigurator: ConfiguratorType {
    
    let requestService: APIService
    
    init(requestService: APIService) {
        self.requestService = requestService
    }
}

enum MostViewedViewInputEvent: EventsType {
    case emailedModel(EmailedModel)
}

enum MostViewedViewOutPutEvent: EventsType {
    case getEmailedModel
}

class MostViewedViewModel: ViewModel<MostViewedViewModelConfigurator, MostViewedViewInputEvent, MostViewedViewOutPutEvent> {
    
}
