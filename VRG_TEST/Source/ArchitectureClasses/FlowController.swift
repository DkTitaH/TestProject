//
//  FlowController.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FlowController<Events: EventsType>: UINavigationController, UINavigationControllerDelegate {
    
    let eventHandler = PublishSubject<Events>()
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = self
        self.isNavigationBarHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
    
    open func start() {
        
    }
}

extension FlowController {
    
    func push(viewController: UIViewController) {
        self.pushViewController(viewController, animated: true)
    }
}
