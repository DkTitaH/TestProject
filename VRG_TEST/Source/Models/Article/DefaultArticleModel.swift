//
//  DefaultArticleModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

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
