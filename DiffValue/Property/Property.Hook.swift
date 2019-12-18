//
//  Property.Hook.swift
//  DiffValue
//
//  Created by Haider Khan on 12/17/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation

public enum Hook<Listener: AnyObject, Property> {
    
    public typealias MethodHandle = (Listener) -> (Property) -> Void
    public typealias ClosureHandle = (Property) -> Void
    
    case method(MethodHandle)
    case closure(ClosureHandle)
    
}
