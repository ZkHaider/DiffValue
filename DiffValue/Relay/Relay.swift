//
//  Relay.swift
//  DiffValue
//
//  Created by Haider Khan on 11/11/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation
import Combine

/**
    From: https://github.com/dduan/Relay
 */

/// A publisher that exposes a method for outside callers to publish elements.
///
/// A relay is a publisher that you can use to ”inject” values into a stream, by calling its `send()` method. This can be useful for adapting existing imperative code to the Combine model.
///
/// It's very similar to a subject
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol Relay: AnyObject, Publisher {

    /// Sends a value to the subscriber.
    ///
    /// - Parameter value: The value to send.
    func send(_ value: Self.Output)
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Relay where Self.Output == Void {
    /// Signals subscribers.
    public func send() {
        self.send(())
    }
}


