//
//  Publishers+CombineLatestCollection.swift
//  
//
//  Created by Q Trang on 8/1/20.
//

import Foundation
import Combine

extension Collection where Element: Publisher {
    public var combineLatest: CombineLatestCollection<Self> {
        CombineLatestCollection(self)
    }
}

public struct CombineLatestCollection<Publishers>: Publisher where Publishers: Collection, Publishers.Element: Publisher {
    public typealias Output = [Publishers.Element.Output]
    public typealias Failure = Publishers.Element.Failure
    
    private let publishers: Publishers
    
    public init(_ publishers: Publishers) {
        self.publishers = publishers
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = Subscription(subscriber: subscriber, publishers: publishers)
        subscriber.receive(subscription: subscription)
    }
}

extension CombineLatestCollection {
    fileprivate final class Subscription<S: Subscriber>: Combine.Subscription where S.Failure == Failure, S.Input == Output {
        
        private let subscribers: [AnyCancellable]
        
        init(subscriber: S, publishers: Publishers) {
            let count = publishers.count
            var outputs: [Publishers.Element.Output?] = Array(repeating: nil, count: count)
            
            var completions = 0
            var hasCompleted = false
            let lock = NSLock()
            
            subscribers = publishers.enumerated().map { index, publisher in
                publisher.sink(receiveCompletion: { completion in
                    lock.lock()
                    defer { lock.unlock() }
                    
                    guard case .finished = completion else {
                        subscriber.receive(completion: completion)
                        hasCompleted = true
                        return
                    }
                    
                    completions += 1
                    
                    guard completions == count else { return }
                    
                    subscriber.receive(completion: completion)
                    hasCompleted = true
                }) { value in
                    lock.lock()
                    defer { lock.unlock() }
                    
                    guard !hasCompleted else { return }
                    
                    outputs[index] = value
                    
                    let values = outputs.compactMap { $0 }
                    
                    guard values.count == count else { return }
                    
                    _ = subscriber.receive(values)
                }
            }
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscribers.forEach { $0.cancel() }
        }
    }
}

