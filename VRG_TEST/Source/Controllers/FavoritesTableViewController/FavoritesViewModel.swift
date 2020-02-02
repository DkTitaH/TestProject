//
//  FavoritesViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

class FavoritesViewModelConfigurator: ConfiguratorType {
    
    let requestService: APIService
    
    init(requestService: APIService) {
        self.requestService = requestService
    }
}

enum FavoritesViewEvents: EventsType {
    
}

class FavoritesViewModel: ViewModel<FavoritesViewModelConfigurator, FavoritesViewEvents> {
    
}
