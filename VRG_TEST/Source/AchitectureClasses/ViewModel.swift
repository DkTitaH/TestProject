//
//  ViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel<Configurator: ConfiguratorType, InputEvents: EventsType, OutPutEvents: EventsType> {
    
    var events: Observable<InputEvents> {
        return self.internalEventHandler.asObservable()
    }
    
    let eventHandler = PublishSubject<OutPutEvents>()
    
    let internalEventHandler = PublishSubject<InputEvents>()
    let disposeBag = DisposeBag()

    init(configurator: Configurator) {

    }
}
