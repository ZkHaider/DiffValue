//
//  Diffable.KeyPath.swift
//  DiffValue
//
//  Created by Haider Khan on 11/10/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation

public struct DiffableKeyPath<Root> {
    
    // MARK: - Attributes
    
    internal let partialKeyPath: PartialKeyPath<Root>
    internal let comparing: Comparing<Root>
    
    // MARK: - Init 
    
    internal init(partialKeyPath: PartialKeyPath<Root>,
         comparing: Comparing<Root>) {
        self.partialKeyPath = partialKeyPath
        self.comparing = comparing
    }
    
}

extension DiffableKeyPath: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.partialKeyPath.hashValue)
    }
    
    public static func ==(lhs: DiffableKeyPath<Root>,
                          rhs: DiffableKeyPath<Root>) -> Bool {
        return lhs.partialKeyPath == rhs.partialKeyPath
    }
    
}
