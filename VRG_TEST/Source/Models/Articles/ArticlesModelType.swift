//
//  ArticlesModelType.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

protocol ArticlesModelType: Codable {
    
    associatedtype Model = ArticleModelType
    
    static var type: ArticleType { get }
    
    var copyright: String { get }
    var numResults: Int { get }
    var results: [Model] { get }
    var status: String { get }
}
