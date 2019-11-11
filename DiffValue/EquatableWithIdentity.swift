//
//  EquatableWithIdentity.swift
//  DiffValue
//
//  Created by Haider Khan on 11/10/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation

/// Identity protocol provides a default implementation of the type that conforms to it.
public protocol HasIdentity {
    static var identity: Self { get }
}

public typealias EquatableWithIdentity = HasIdentity & Equatable
