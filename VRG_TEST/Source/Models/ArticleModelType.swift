//
//  ArticleDetailModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 02.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

protocol ArticleModelType: Codable {
    
    var adxKeywords: String { get }
    var abstract: String { get }
    var id: Int { get }
    var count: Int { get }
    var source: String { get }
    var title: String { get }
    var publishedDate: String { get }
    var countType: String { get }    
}

struct DefaultArticleModel: ArticleModelType {
    let adxKeywords: String
    let abstract: String
    let id: Int
    let count: Int
    let source: String
    let title: String
    let publishedDate: String
    let countType: String
}
