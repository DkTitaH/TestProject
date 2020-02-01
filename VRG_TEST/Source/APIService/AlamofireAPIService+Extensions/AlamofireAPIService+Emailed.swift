//
//  AlamofireAPIService+Emailed.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

extension AlamofireAPIService {
    
    func getEmailedArticles(completion: @escaping (Result<EmailedModel, APIServiceError>) -> ()) {
        self.task = self.requestData(
            url: .init(api: .value, type: .emailed, period: .day),
            method: .get
        ) { result in
            switch result {
            case let .success(data):
                if let emailedModel = try? self.decoder.decode(EmailedModel.self, from: data) {
                    completion(.success(emailedModel))
                } else {
                    completion(.failure(.jsonParsingError))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
