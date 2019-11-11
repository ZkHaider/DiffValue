//
//  Single.Replay.swift
//  DiffValue
//
//  Created by Haider Khan on 11/11/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation

import Combine

internal final class SingleReplaySubscription<Output, Failure: Error>: Subscription {
    
    let capacity: Int
    var subscriber: AnySubscriber<Output, Failure>? = nil
    var demand: Subscribers.Demand = .none
    var output: Output? = nil
    var completion: Subscribers.Completion<Failure>? = nil
    
    init<S>(subscriber: S,
            replay: Output?,
            capacity: Int,
            completion: Subscribers.Completion<Failure>?) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        self.subscriber = AnySubscriber(subscriber)
        self.output = replay
        self.capacity = capacity
        self.completion = completion
    }
    
    func receive(_ input: Output) {
        guard subscriber != nil else { return }
        self.output = input
        if capacity == 0 { self.output = nil }
        emitAsNeeded()
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        guard let subscriber = self.subscriber else { return }
        self.subscriber = nil
        self.output = nil
        subscriber.receive(completion: completion)
    }
    
    func request(_ demand: Subscribers.Demand) {
        if demand != .none {
            self.demand += demand
        }
        emitAsNeeded()
    }
    
    func cancel() {
        complete(with: .finished)
    }
    
    private func complete(with completion: Subscribers.Completion<Failure>) {
        guard
            let subscriber = self.subscriber
            else { return }
        self.subscriber = nil
        self.completion = nil
        self.output = nil
        subscriber.receive(completion: completion)
    }
    
    private func emitAsNeeded() {
        guard
            let subscriber = self.subscriber,
            let output = self.output
            else { return }
        
        if self.demand > .none {
            self.demand -= .max(1)
            let nextDemand = subscriber.receive(output)
            if nextDemand != .none {
                self.demand += nextDemand
            }
        }
        
        if let completion = completion {
            complete(with: completion)
        }
    }
    
}
