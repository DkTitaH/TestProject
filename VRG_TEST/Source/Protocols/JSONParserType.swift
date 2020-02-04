//
//  JSONParserType.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

protocol JSONParserType {
    func parse<ArticlesModel: ArticlesModelType>(data: Data) -> (ArticlesModel?, APIServiceError?)
}
