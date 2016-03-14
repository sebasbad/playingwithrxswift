//: Playground - noun: a place where people can play

import UIKit
import RxSwift

//let scheduler = MainScheduler.instance
//let scheduler = CurrentThreadScheduler.instance
//let scheduler = SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Default)
let scheduler = ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Default)

let subscription = Observable<Int>.interval(0.3, scheduler: scheduler)
    .subscribe { event in
        print(event)
}

NSThread.sleepForTimeInterval(2)

subscription.dispose()

