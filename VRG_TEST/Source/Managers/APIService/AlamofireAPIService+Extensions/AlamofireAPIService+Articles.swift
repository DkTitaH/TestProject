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
                let (model, error): (ArticlesModel?, APIServiceError?) = self.parser.parse(data: data)
                model.do { completion(.success($0)) }
                error.do { completion(.failure($0)) }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
