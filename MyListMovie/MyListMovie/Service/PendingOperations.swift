//
//  PendingOperations.swift
//  MyListMovie
//
//  Created by Teuku Mulia Ichsan on 09/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

/// Monitoring of progress queue
class PendingOperations {
    
    // lazy var is property whose initial value is not calculated until first time its used
    // prevents variables from being initialized when they are not needed
    lazy var downloadInProgress: [IndexPath: Operation] = [:]
    
    
    // initial download queue as concurrent queue with max : 2
       lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.dicoding.imagedownload"
        queue.maxConcurrentOperationCount = 2
        return queue
    }()

}
