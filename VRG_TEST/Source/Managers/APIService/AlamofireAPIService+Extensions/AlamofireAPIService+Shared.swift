//
//  AlamofireAPIService+Shared.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

extension AlamofireAPIService {
    
    func getSharedArticles(completion: @escaping (Result<SharedModel, APIServiceError>) -> ()) {
        self.task = self.requestData(
            url: .init(api: .value, type: .shared, period: .month),
            method: .get
        ) { result in
            switch result {
            case let .success(data):
                if let sharedModel = try? self.decoder.decode(SharedModel.self, from: data) {
                    completion(.success(sharedModel))
                } else {
                    completion(.failure(.jsonParsingError))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
