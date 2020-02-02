//
//  ViewModel.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel<Configurator: ConfiguratorType, Events: EventsType> {
    
    var events: Observable<Events> {
        return self.eventHandler.asObservable()
    }
    
    let eventHandler = PublishSubject<Events>()
    let disposeBag = DisposeBag()

    init(configurator: Configurator) {

    }
    
    open func handle(events: Events) {
        
    }
}
