//
//  UINavBar+Extensions.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    func configureTabBar(_ action: @escaping (UITabBar) -> ())  {
        return action(self.tabBar)
    }
}
