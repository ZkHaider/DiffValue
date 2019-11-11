//
//  Diff.swift
//  DiffValue
//
//  Created by Haider Khan on 11/10/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
public struct Diff<Value: Equatable> {
    
    // MARK: - Definitions
    
    public typealias DiffValue = Value
    public typealias Relay = CurrentValueRelay<Value, Never>
    
    // MARK: - Wrapped Value
        
    public var wrappedValue: Value {
        get {
            return relay.value
        }
        set {
            // Diff here
            guard
                Diff.diff(
                    keyPaths: self.diffableKeyPaths,
                    lhs: self.relay.value,
                    rhs: newValue
                ).count == 0
                else {
                    
                    // Set new property this automatically updates subscribers on
                    // relay as well
                    self.relay.send(newValue)
                    return
            }
            
            // There are no changes observed
            return
        }
    }
    
    // MARK: - Attributes
    
    private let relay: Relay
    
    // MARK: - Projected Value
    
    public var projectedValue: Relay {
        return self.relay
    }
    
    // MARK: - KeyPaths
    
    let diffableKeyPaths: Set<DiffableKeyPath<Value>>
    
    // MARK: - Initializers
    
    public init(value: Value)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set()
    }
    
    public init(value: Value, keyPaths: DiffableKeyPath<Value>...)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(keyPaths)
    }
    
    public init(value: Value, keyPaths: [DiffableKeyPath<Value>])
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(keyPaths)
    }
    
    public init<Property1: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral: keyPath1.diffable)
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable>(
        value: Value ,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable,
        Property7: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>,
        _ keyPath7: KeyPath<Value, Property7>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable,
            keyPath7.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable,
        Property7: Equatable,
        Property8: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>,
        _ keyPath7: KeyPath<Value, Property7>,
        _ keyPath8: KeyPath<Value, Property8>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable,
            keyPath7.diffable,
            keyPath8.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable,
        Property7: Equatable,
        Property8: Equatable,
        Property9: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>,
        _ keyPath7: KeyPath<Value, Property7>,
        _ keyPath8: KeyPath<Value, Property8>,
        _ keyPath9: KeyPath<Value, Property9>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable,
            keyPath7.diffable,
            keyPath8.diffable,
            keyPath9.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable,
        Property7: Equatable,
        Property8: Equatable,
        Property9: Equatable,
        Property10: Equatable>(
        value: Value,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>,
        _ keyPath7: KeyPath<Value, Property7>,
        _ keyPath8: KeyPath<Value, Property8>,
        _ keyPath9: KeyPath<Value, Property9>,
        _ keyPath10: KeyPath<Value, Property10>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable,
            keyPath7.diffable,
            keyPath8.diffable,
            keyPath9.diffable,
            keyPath10.diffable
        )
    }
    
}

extension Diff where Value: EquatableWithIdentity {
    
    // MARK: - Convenience Initializers
    
    public init(value: Value = .identity)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set()
    }
    
    public init(value: Value = .identity, keyPaths: DiffableKeyPath<Value>...)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(keyPaths)
    }
    
    public init(value: Value = .identity, keyPaths: [DiffableKeyPath<Value>])
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(keyPaths)
    }
    
    public init<Property1: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral: keyPath1.diffable)
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable,
        Property7: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>,
        _ keyPath7: KeyPath<Value, Property7>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable,
            keyPath7.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable,
        Property7: Equatable,
        Property8: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>,
        _ keyPath7: KeyPath<Value, Property7>,
        _ keyPath8: KeyPath<Value, Property8>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable,
            keyPath7.diffable,
            keyPath8.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable,
        Property7: Equatable,
        Property8: Equatable,
        Property9: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>,
        _ keyPath7: KeyPath<Value, Property7>,
        _ keyPath8: KeyPath<Value, Property8>,
        _ keyPath9: KeyPath<Value, Property9>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable,
            keyPath7.diffable,
            keyPath8.diffable,
            keyPath9.diffable
        )
    }
    
    public init<
        Property1: Equatable,
        Property2: Equatable,
        Property3: Equatable,
        Property4: Equatable,
        Property5: Equatable,
        Property6: Equatable,
        Property7: Equatable,
        Property8: Equatable,
        Property9: Equatable,
        Property10: Equatable>(
        value: Value = .identity,
        _ keyPath1: KeyPath<Value, Property1>,
        _ keyPath2: KeyPath<Value, Property2>,
        _ keyPath3: KeyPath<Value, Property3>,
        _ keyPath4: KeyPath<Value, Property4>,
        _ keyPath5: KeyPath<Value, Property5>,
        _ keyPath6: KeyPath<Value, Property6>,
        _ keyPath7: KeyPath<Value, Property7>,
        _ keyPath8: KeyPath<Value, Property8>,
        _ keyPath9: KeyPath<Value, Property9>,
        _ keyPath10: KeyPath<Value, Property10>)
    {
        self.relay = CurrentValueRelay(value)
        self.diffableKeyPaths = Set(arrayLiteral:
            keyPath1.diffable,
            keyPath2.diffable,
            keyPath3.diffable,
            keyPath4.diffable,
            keyPath5.diffable,
            keyPath6.diffable,
            keyPath7.diffable,
            keyPath8.diffable,
            keyPath9.diffable,
            keyPath10.diffable
        )
    }
    
}

extension Diff {
    
    // MARK: - Diffing
    
    internal static func diff(
        keyPaths: Set<DiffableKeyPath<Value>>,
        lhs: Value,
        rhs: Value) -> Set<DiffableKeyPath<Value>>
    {
        
        // Return a set of differences
        var differences = Set<DiffableKeyPath<Value>>()
        
        // Iterate over one set of diffable keypaths these will
        for lhsKeyPath in keyPaths {
            
            // Diff on property
            let propertyIsEqual = lhsKeyPath
                .comparing
                .compare(lhs, rhs)
            
            if !propertyIsEqual {
                differences.insert(lhsKeyPath)
            }
        }
        
        return differences
    }
    
}
