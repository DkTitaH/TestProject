//
//  APIService.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Alamofire
import Foundation

protocol APIServiceType {
    
    func getArticles<ArticlesModel: ArticlesModelType>(completion: @escaping (Result<ArticlesModel, APIServiceError>) -> ()
    ) 
}
