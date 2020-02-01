//
//  AlamofireAPIService+Viewed.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

extension AlamofireAPIService {

    func getViewedArticles(completion: @escaping (Result<ViewedModel, APIServiceError>) -> ()) {
        self.task = self.requestData(
            url: .init(api: .value, type: .viewed, period: .month),
            method: .get
        ) { result in
            switch result {
            case let .success(data):
                if let viewedModel = try? self.decoder.decode(ViewedModel.self, from: data) {
                    completion(.success(viewedModel))
                } else {
                    completion(.failure(.jsonParsingError))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
