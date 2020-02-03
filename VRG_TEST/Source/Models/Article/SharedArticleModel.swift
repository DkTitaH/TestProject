//
//  SharedArticleModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

struct SharedArticleModel: ArticleModelType {
    
    var count: Int {
        return self.shareCount
    }
    
    let abstract: String
    let adxKeywords: String
    let countType: String
    let id: Int
    let shareCount: Int
    let publishedDate: String
    let section: String
    let source: String
    let title: String
    let type: String
    let updated: String

    let url: String
    
    enum CodingKeys: String, CodingKey {
        
        case abstract
        case adxKeywords = "adx_keywords"
        case countType = "count_type"
        case id
        case shareCount = "share_count"
        case publishedDate = "published_date"
        case section
        case source
        case title
        case type
        case updated
        case url
    }
}

