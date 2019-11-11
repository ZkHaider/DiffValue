//
//  Single.Replay.Publisher.swift
//  DiffValue
//
//  Created by Haider Khan on 11/11/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation
import Combine

extension Publishers {
    final class SingleReplay<Upstream: Publisher>: Publisher {
        
        typealias Output = Upstream.Output
        typealias Failure = Upstream.Failure
        
        private let lock = NSRecursiveLock()
        private let upstream: Upstream
        private let capacity: Int
        private var replay: Output? = nil
        private var subscriptions = [SingleReplaySubscription<Output, Failure>]()
        private var completion: Subscribers.Completion<Failure>? = nil
        
        init(upstream: Upstream,
             capacity: Int) {
            self.upstream = upstream
            self.replay = nil
            self.capacity = capacity
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            lock.lock()
            defer {
                lock.unlock()
            }
            
            let subscription = SingleReplaySubscription(
                subscriber: subscriber,
                replay: self.replay,
                capacity: self.capacity,
                completion: self.completion
            )
            
            subscriptions.append(subscription)
            subscriber.receive(subscription: subscription)
            
            guard
                subscriptions.count == 1
                else { return }
            
            let sink: AnySubscriber<Output, Failure> = AnySubscriber(
                receiveSubscription: { (subscription) in
                    subscription.request(.unlimited)
                }, receiveValue: { [weak self] value -> Subscribers.Demand in
                    guard let this = self else { return .none }
                    this.relay(value)
                    return .none
                }, receiveCompletion: { [weak self] in
                    guard let this = self else { return }
                    this.complete($0)
                }
            )
            
            self.upstream.subscribe(sink)
        }
        
        private func relay(_ value: Output) {
            lock.lock()
            defer {
                lock.unlock()
            }
            
            guard
                completion == nil
                else { return }
            
            self.replay = value
            
            guard
                let sendValue = self.replay
                else { return }
            
            subscriptions.forEach {
                $0.receive(sendValue)
            }
        }
        
        private func complete(_ completion: Subscribers.Completion<Failure>) {
            lock.lock()
            defer {
                lock.unlock()
            }
            
            self.completion = completion
            subscriptions.forEach {
                $0.receive(completion: completion)
            }
        }
        
    }
}
