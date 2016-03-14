//
//  IntroductionToRxSwift.swift
//  PlayingWithRxSwift
//
//  Created by Sebastián Badea on 13/3/16.
//  Copyright © 2016 Sebastian Badea. All rights reserved.
//

import Foundation
import RxSwift

struct IntroductionToRxSwift {
   
    static func firstMethod() {
//        let scheduler = MainScheduler.instance
//        let scheduler = CurrentThreadScheduler.instance
//        let scheduler = SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Default)
        let scheduler = ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Default)
        
        let subscription = Observable<Int>.interval(0.3, scheduler: scheduler)
            .subscribe { event in
                print("event=\(event), event.element=\(event.element)")
        }
        
        NSThread.sleepForTimeInterval(2)
        
        subscription.dispose()
    }
}