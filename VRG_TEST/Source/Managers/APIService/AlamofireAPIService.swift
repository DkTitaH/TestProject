//
//  AlamofireAPIService.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import Alamofire

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

enum ObjectType: String, RawRepresentable {

    case emailed = "emailed/"
    case shared = "shared/"
    case viewed = "viewed/"
}

enum ThrdService: String {
    case facebook = "/facebook."
}

class APIUrl {
    
    let url: URL?
    let stringUrl: String
    
    init(
        api: API,
        type: ObjectType,
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

class AlamofireAPIService: AlamofireAPIServiceType, APIService {
    
    var task: NetworkTask? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func requestData(
        url: APIUrl,
        method: HTTPMethod,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<Data, APIServiceError>) -> Void
    )
        -> NetworkTask?
    {
        let response = url.url.flatMap { url in
            AF.request(url, method: method, headers: headers).response { response in
                let result: Result<Data, APIServiceError>
                
                if let error = response.error {
                    result = .failure(.networkError(error))
                } else {
                    result = response.data.flatMap { .success($0) } ?? .success(Data())
                }
                
                completion(result)
            }
        }
        
        return response?.task.map(NetworkTask.init)
    }
}
