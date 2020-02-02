//
//  ArticleDetailViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 02.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

struct ArticleDetailViewModelConfigurator: ConfiguratorType {
    
}

enum ArticleDetailViewEvents: EventsType {
    case addToFavorites
}

class ArticleDetailViewModel: ViewModel<ArticleDetailViewModelConfigurator, ArticleDetailViewEvents> {
    
}
