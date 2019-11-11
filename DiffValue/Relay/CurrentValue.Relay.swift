//
//  CurrentValue.Relay.swift
//  DiffValue
//
//  Created by Haider Khan on 11/11/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation
import Combine

/**
   From: https://github.com/dduan/Relay
   Modified slightly.
*/

/// A relay that wraps a single value and publishes a new element whenever the value changes.
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper public final class CurrentValueRelay<Output, Failure>: Relay where Failure: Error {
    
    /// Wrapped value
    public typealias Value = Output
    
    /// The subject that is kept hidden
    private let subject: CurrentValueSubject<Output, Failure>
    
    /// The value wrapped by this relay, published as a new element whenever it changes.
    public var value: Output {
        return self.subject.value
    }
    
    /// Wrapped value which is property wrapper value
    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            self.subject.value = newValue
        }
    }
    
    public var projectedValue: CurrentValueRelay<Output, Failure> {
        return self
    }

    /// Creates a current value relay with the given initial value.
    ///
    /// - Parameter value: The initial value to publish.
    public init(_ value: Output) {
        self.subject = CurrentValueSubject(value)
    }

    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
    ///
    /// - SeeAlso: `subscribe(_:)`
    /// - Parameters:
    ///     - subscriber: The subscriber to attach to this `Publisher`.
    ///                   once attached it can begin to receive values.
    public func receive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S : Subscriber {
        self.subject.receive(subscriber: subscriber)
    }
    
    public func projectedReceive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S: Subscriber {
        return receive(subscriber: subscriber)
    }

    /// Sends a value to the subscriber.
    ///
    /// - Parameter value: The value to send.
    final public func send(_ input: Output) {
        self.subject.send(input)
    }
}

extension CurrentValueRelay where Output: EquatableWithIdentity {
    
    public convenience init(with value: Output = Output.identity) {
        self.init(value)
    }
    
}
