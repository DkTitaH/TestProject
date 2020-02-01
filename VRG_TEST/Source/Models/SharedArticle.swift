//
//  SharedArticle.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

struct SharedModel: Codable {
    
    let copyright: String
    let numResults: Int
    let results: [SharedArticleModel]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case copyright
        case numResults = "num_results"
        case results
        case status
    }
}

struct SharedArticleModel: Codable {
    
    //    let abstract: String
    //    let adxKeywords: String
    //    let assetId: Int
    //    let byline: String
    //    let column: String
    //    let countType: String
    //    let desFacet: [String]
    //    let emailCount: Int
    //    let etaId: Int
    //    let geoFacet: [String]
    let id: Int
    //    let media: [MedaiModel]
    //    let nytdsection: String
    //    let orgFacet: [String]
    //    let perFacet: [String]
    let shareCount: Int
    let publishedDate: String
    let section: String
    let source: String
    //    let subsection: String
    let title: String
    let type: String
    let updated: String
    //    let uri: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        
        //        case abstract
        //        case adxKeywords = "adx_keywords"
        //        case assetId = "asset_id"
        //        case byline
        //        case column
        //        case countType = "count_type"
        //        case desFacet = "des_facet"
        //        case emailCount = "email_count"
        //        case etaId = "eta_id"
        //        case geoFacet = "geo_facet"
        case id
        //        case media
        //        case nytdsection
        //        case orgFacet = "org_facet"
        //        case perFacet = "per_facet"
        case shareCount = "share_count"
        case publishedDate = "published_date"
        case section
        case source
        //        case subsection
        case title
        case type
        case updated
        //        case uri
        case url
    }
}

