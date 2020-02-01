//
//  NetworkTask.swift
//  VRG_TEST
//
//  Created by Vladymyr Martyniuk on 01.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation

class NetworkTask {
    
    public private(set) var isCancelled = false
    
    private let task: URLSessionTask
    
    init(task: URLSessionTask) {
        self.task = task
    }
    
    public func cancel() {
        if self.task.state == .running {
            self.task.cancel()
        }
        
        self.isCancelled = true
    }
}
