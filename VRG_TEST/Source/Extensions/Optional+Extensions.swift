//
//  Optional+Extension.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

extension Optional {
    
    func `do`(_ action: (Wrapped) -> ()) {
        self.map(action)
    }
}
