//: [Previous](@previous)

import Foundation
import RxSwift

func myFrom<E>(sequence: [E]) -> Observable<E> {
    return Observable.create { observer in
        for element in sequence {
            observer.on(.Next(element))
        }
        
        observer.on(.Completed)
        return NopDisposable.instance
    }
}

let stringCounter = myFrom(["first", "second"])

print("Started ----")

// first time
stringCounter
    .subscribeNext { n in
        print(n)
}

print("----")

// again
stringCounter
    .subscribeNext { n in
        print(n)
}

print("Ended ----")