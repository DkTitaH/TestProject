//
//  MediaModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

struct MedaiModel: Codable {
    
    let approved_for_syndication: Bool
    let caption: String
    let copyright: String
    let media_metadata: [MediaMetaDataModel]
    let subtype: String
    let type: String
}

struct MediaMetaDataModel: Codable {
    
    let format: String
    let height: Int
    let url: String
    let width: Int
}
