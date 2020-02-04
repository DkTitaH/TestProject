//
//  AlamofireAPIService.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireAPIService: AlamofireAPIServiceType, APIServiceType {
    
    var task: NetworkTask? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    let parser: JSONParser
    
    init(parser: JSONParser) {
        self.parser = parser
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
