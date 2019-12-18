//
//  Property.Relay.swift
//  DiffValue
//
//  Created by Haider Khan on 12/17/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation
import Combine

internal protocol AnyPropertyRelay {
    func anyUpdate(any partialKeyPath: AnyKeyPath,
                   with anyValue: Any)
}

internal protocol InternalPropertyRelay: AnyPropertyRelay {
    associatedtype Property: Any
    associatedtype Value: Any
    func update(partialKeyPath: PartialKeyPath<Property>,
                with value: Value)
}

extension InternalPropertyRelay {
    
    func anyUpdate(any keyPath: AnyKeyPath,
                   with anyValue: Any) {
        guard
            let castedPartialKeyPath = keyPath as? PartialKeyPath<Property>,
            let castedValue = anyValue as? Value
            else { return }
        update(partialKeyPath: castedPartialKeyPath, with: castedValue)
    }
    
}

internal final class PropertyRelay<
                    Value: Equatable,
                    Property>: InternalPropertyRelay {

    
    // MARK: - Relay
    
    internal let keyPath: KeyPath<Value, Property>
    internal let relay: CurrentValueRelay<Value, Never>
    
    // MARK: - Init
    
    init(value: Value,
         keyPath: KeyPath<Value, Property>)
    {
        self.keyPath = keyPath
        self.relay = CurrentValueRelay(value)
    }
    
    // MARK: - Update
    
    func update(partialKeyPath: PartialKeyPath<Property>,
                with value: Value) {
        guard
            keyPath.hashValue == partialKeyPath.hashValue
            else { return }
        self.relay.send(value)
    }
    
}
