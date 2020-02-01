//
//  MostSharedViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

class MostSharedViewModelConfigurator: ConfiguratorType {
 
    let requestService: APIService
    
    init(requestService: APIService) {
        self.requestService = requestService
    }
}

enum MostSharedViewInputEvent: EventsType {
    case emailedModel(EmailedModel)
}

enum MostSharedViewOutPutEvent: EventsType {
    case getEmailedModel
}


class MostSharedViewModel: ViewModel<MostSharedViewModelConfigurator, MostSharedViewInputEvent, MostSharedViewOutPutEvent> {
    
}
