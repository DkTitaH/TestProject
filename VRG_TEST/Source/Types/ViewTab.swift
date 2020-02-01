//
//  ViewTab.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit

class ViewTab {
    
    let controller: UIViewController
    let item: UITabBarItem
    
    init(title: String, controller: UIViewController, image: UIImage? = nil, selectedImage: UIImage? = nil) {
        controller.title = title
        
        self.controller = controller
        self.item = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
}
