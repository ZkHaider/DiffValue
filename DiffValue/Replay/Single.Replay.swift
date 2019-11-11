//
//  Single.Replay.swift
//  DiffValue
//
//  Created by Haider Khan on 11/11/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import Foundation
import Combine

extension Publisher {
    func singleReplay() -> Publishers.SingleReplay<Self> {
        return Publishers.SingleReplay(upstream: self, capacity: 1)
    }
}
