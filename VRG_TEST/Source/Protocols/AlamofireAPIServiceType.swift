//
//  AlamofireAPIServiceType.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamofireAPIServiceType {
    
    func requestData(url: APIUrl, method: HTTPMethod, headers: HTTPHeaders?, completion: @escaping (Result<Data, APIServiceError>) -> Void) -> NetworkTask?
}
