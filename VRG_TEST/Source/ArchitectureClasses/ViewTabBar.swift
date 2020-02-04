//
//  TabBarViewController.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewTabBar<Events: EventsType>: UITabBarController {
    
    let eventHandler = PublishSubject<Events>()
    
    private let tabs: [ViewTab]
    
    init(viewTabs: [ViewTab]) {
        self.tabs = viewTabs
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
    
    private func start() {
        self.viewControllers = self.tabs.map {
            $0.controller.navigationController?.isNavigationBarHidden = true
            
            return $0.controller
        }
    }
}
