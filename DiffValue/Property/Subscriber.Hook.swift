//
//  Subscriber.Hook.swift
//  DiffValue
//
//  Created by Haider Khan on 12/17/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation
import Combine

/// From OpenCombine
fileprivate enum SubscriptionStatus {
    case awaitingSubscription
    case subscribed(Subscription)
    case terminal
}

extension Publisher where Output: Equatable, Self.Failure == Never {

    public func add<
        Value: Equatable,
        Target: AnyObject,
        Property>(
        _ keyPath: KeyPath<Value, Property>,
        target: Target,
        hook: Hook<Target, Property>) -> AnyCancellable
        where Value == Output
    {
        return AnyCancellable(internalAdd(keyPath, target: target, hook: hook))
    }

    private func internalAdd<
        Value: Equatable,
        Target: AnyObject,
        Property>(
        _ keyPath: KeyPath<Value, Property>,
        target: Target,
        hook: Hook<Target, Property>) -> Subscribers.PropertyHook<Target, Value, Property>
        where Value == Output
    {
        let subscriber = Subscribers.PropertyHook(
            keyPath,
            target: target,
            hook: hook
        )
        subscribe(subscriber)
        return subscriber
    }

}

extension Subscribers {
    internal final class PropertyHook<
                    Target: AnyObject,
                    Value: Equatable,
                    Property>: Subscriber, Cancellable {
        
        // MARK: - Attributes
        
        private(set) weak var _listener: Target? = nil
        internal var listener: Target? {
            return _listener
        }
        
        let keyPath: KeyPath<Value, Property>
        let hook: Hook<Target, Property>
        
        private var status: SubscriptionStatus = .awaitingSubscription
        
        // MARK: - Init
        
        init(
            _ keyPath: KeyPath<Value, Property>,
            target: Target,
            hook: Hook<Target, Property>)
        {
            self.keyPath = keyPath
            self._listener = target
            self.hook = hook
        }
        
        // MARK: - Receiving
        
        func receive(subscription: Subscription) {
            switch status {
            case .subscribed, .terminal:
                subscription.cancel()
            case .awaitingSubscription:
                status = .subscribed(subscription)
                subscription.request(.unlimited)
            }
        }
        
        public func receive(_ value: Value) -> Subscribers.Demand {
            switch status {
            case .subscribed:
                guard
                    let listener = self.listener
                    else { return .none }
                switch self.hook {
                case .method(let method):
                    let property = value[keyPath: self.keyPath]
                    method(listener)(property)
                case .closure(let closure):
                    let property = value[keyPath: self.keyPath]
                    closure(property)
                }
            case .awaitingSubscription, .terminal:
                break
            }
            return .none
        }
        
        public func receive(completion: Subscribers.Completion<Never>) {
            cancel()
        }
        
        public func cancel() {
            guard case let .subscribed(subscription) = status else {
                return
            }
            subscription.cancel()
            status = .terminal
        }
        
    }
    
}
