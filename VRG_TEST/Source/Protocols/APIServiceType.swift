//
//  APIService.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Alamofire
import Foundation

enum APIServiceError: Error {
    
    case networkError(Error)
    case dataNotFound
    case jsonParsingError
    case invalidStatusCode(Int)
}

protocol AlamofireAPIServiceType {
    
    func requestData(url: APIUrl, method: HTTPMethod, headers: HTTPHeaders?, completion: @escaping (Result<Data, APIServiceError>) -> Void) -> NetworkTask?
}

protocol APIService {
    
    func getEmailedArticles(completion: @escaping (Result<EmailedModel, APIServiceError>) -> ())
    
    func getSharedArticles(completion: @escaping (Result<SharedModel, APIServiceError>) -> ())
    
    func getViewedArticles(completion: @escaping (Result<ViewedModel, APIServiceError>) -> ())
}
