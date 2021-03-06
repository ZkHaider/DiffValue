//
//  Diff.KeyPath.Subscription.swift
//  DiffValue
//
//  Created by Haider Khan on 12/17/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation

extension Diff {
    
    public func observe<
        Target: AnyObject,
        Property>(
        _ keyPath: KeyPath<DiffValue, Property>,
        target: Target,
        hook: Hook<Target, Property>,
        on queue: DispatchQueue? = nil)
    {
        if let queue = queue {
            self.cancellables.append(
                self.relay
                    .receive(on: queue)
                    .add(
                        keyPath,
                        target: target,
                        hook: hook
                    )
            )
        } else {
            self.cancellables.append(
                self.relay.add(
                    keyPath,
                    target: target,
                    hook: hook
                )
            )
        }
    }
    
}
