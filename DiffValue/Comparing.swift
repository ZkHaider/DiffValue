//
//  Comparing.swift
//  DiffValue
//
//  Created by Haider Khan on 11/10/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation

struct Comparing<Root> {
    let compare: (Root, Root) -> Bool
}

extension KeyPath where Value: Equatable {
    
    internal func compare(oldValue: Root, newValue: Root) -> Bool {
        let old = oldValue[keyPath: self]
        let new = newValue[keyPath: self]
        return old == new
    }
    
    internal var comparing: Comparing<Root> {
        return Comparing<Root>(compare: self.compare)
    }
    
    public var diffable: DiffableKeyPath<Root> {
        return DiffableKeyPath(partialKeyPath: self,
                               comparing: self.comparing)
    }
    
}
