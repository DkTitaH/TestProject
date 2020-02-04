//
//  Reactive+UIViewControllerExtensions.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 04.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<()> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).mapVoid()
        return ControlEvent(events: source)
    }
}
