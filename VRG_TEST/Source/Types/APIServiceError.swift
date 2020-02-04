//
//  APIServiceError.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    
    case networkError(Error)
    case dataNotFound
    case jsonParsingError
    case invalidStatusCode(Int)
}
