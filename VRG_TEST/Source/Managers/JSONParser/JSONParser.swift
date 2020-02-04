//
//  JSONParser.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

class JSONParser: JSONParserType {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func parse<ArticlesModel: ArticlesModelType>(data: Data) -> (ArticlesModel?, APIServiceError?) {
        if let model = try? self.decoder.decode(ArticlesModel.self, from: data) {
            return (model, nil)
        } else {
            return (nil, .jsonParsingError)
        }
    }
}
