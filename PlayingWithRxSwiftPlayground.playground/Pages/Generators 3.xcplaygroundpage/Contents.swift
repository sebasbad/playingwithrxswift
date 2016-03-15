//: [Previous](@previous)

import Foundation
import RxSwift

func myInterval(interval: NSTimeInterval) -> Observable<Int> {
    return Observable.create { observer in
        print("Subscribed")
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        
        var next = 0
        
        dispatch_source_set_timer(timer, 0, UInt64(interval * Double(NSEC_PER_SEC)), 0)
        let cancel = AnonymousDisposable {
            print("Disposed")
            dispatch_source_cancel(timer)
        }
        dispatch_source_set_event_handler(timer, {
            if cancel.disposed {
                return
            }
            observer.on(.Next(next))
            next += 1
        })
        dispatch_resume(timer)
        
        return cancel
    }
}

//let counter = myInterval(0.1)
let counter = myInterval(0.1).shareReplay(3)

print("Started ----")

let subscription = counter
    .subscribeNext { n in
        print(n)
}

let subscription2 = counter
    .subscribeNext { n in
        print("Second \(n)")
}

NSThread.sleepForTimeInterval(0.5)

subscription.dispose()

let subscription3 = counter
    .subscribeNext { n in
        print("Third \(n)")
}

NSThread.sleepForTimeInterval(0.5)

subscription2.dispose()

NSThread.sleepForTimeInterval(0.5)

subscription3.dispose()

print("Ended ----")
