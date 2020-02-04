//
//  Observable+Extensions.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Observable {
    
    func mapVoid() -> Observable<Void> {
        return map { _ in Void() }
    }
}
