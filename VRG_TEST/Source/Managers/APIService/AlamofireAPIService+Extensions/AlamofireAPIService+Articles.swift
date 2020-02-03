//
//  AlamofireAPIService+Emailed.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

extension AlamofireAPIService {
    
    func getArticles<ArticlesModel: ArticlesModelType>(completion: @escaping (Result<ArticlesModel, APIServiceError>) -> ()
    ) {
        self.task = self.requestData(
            url: .init(api: .value, type: ArticlesModel.type, period: .month),
            method: .get
        ) { result in
            switch result {
            case let .success(data):
                if let model = try? self.decoder.decode(ArticlesModel.self, from: data) {
                    completion(.success(model))
                } else {
                    completion(.failure(.jsonParsingError))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


protocol JSONParserType {
    func parse<ArticlesModel: ArticlesModelType>(data: Data) -> (ArticlesModel?, APIServiceError?)
}

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
