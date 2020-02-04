//
//  APIUrl.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

enum API: String {
    case value = "https://api.nytimes.com/svc/mostpopular/v2/"
}

enum Authorized: String {
    case key = "json?api-key=4k0JjvtCm6LmqWCXaWgC9X2Ej2tfcG7j"
}

enum Period: String {
    case day = "1"
    case week = "7"
    case month = "30"
}

enum ArticleType: String, RawRepresentable {
    
    case emailed = "emailed/"
    case shared = "shared/"
    case viewed = "viewed/"
    case `default`
}

enum ThrdService: String {
    case facebook = "/facebook."
}

class APIUrl {
    
    let url: URL?
    let stringUrl: String
    
    init(
        api: API,
        type: ArticleType,
        period: Period,
        thrdService: ThrdService? = nil,
        key: Authorized = .key
        ) {
        let apiValue = api.rawValue + type.rawValue
        let periodValue = thrdService
            .map { serviceName in
                period.rawValue + serviceName.rawValue
            }
            ?? period.rawValue + "."
        
        let stringUrl = apiValue + periodValue + key.rawValue
        self.stringUrl = stringUrl
        self.url = URL(string: stringUrl)
    }
}
