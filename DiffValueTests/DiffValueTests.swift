//
//  DiffValueTests.swift
//  DiffValueTests
//
//  Created by Haider Khan on 11/10/19.
//  Copyright © 2019 Haider Khan. All rights reserved.
//

import XCTest
import Combine
@testable import DiffValue

extension State: EquatableWithIdentity {
    static var identity: State {
        return State(stringProperty: "", intProperty: 0)
    }
}

struct State {
    let stringProperty: String
    let intProperty: Int
}

final class ExampleClass {
    
    @Diff(\.stringProperty, \.intProperty)
    var state1: State

    @Diff(\.intProperty)
    var state2: State

    @Diff(\.stringProperty)
    var state3: State
}

class DiffValueTests: XCTestCase {
    
    let exampleClass = ExampleClass()
    let passthroughSubject = PassthroughSubject<State, Never>()
    
    var subscriptions: [AnyCancellable] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func handleStringProperty(_ string: String) {
        print("Hook Method Hit: \(string)")
    }

    func testDiffState() {
        
        var modifiedState = State(stringProperty: "", intProperty: 0)

        /// Setup subscriptions

        // State 1

        // Test our property observer
        exampleClass.$state1.observe(
            \.stringProperty,
            target: self,
            hook: .method(DiffValueTests.handleStringProperty)
        )
        
        let relay1 = exampleClass.$state1.relay
        let replay1 = relay1
            .print("DiffStateReplay1")
            .singleReplay()

        replay1.sink { (state) in

        }.store(in: &subscriptions)

        replay1.sink { (state) in

        }.store(in: &subscriptions)

        // State 2

        let relay2 = exampleClass.$state2.relay
        let replay2 = relay2
            .print("DiffStateReplay2")
            .singleReplay()

        replay2.sink { (state) in

        }.store(in: &subscriptions)

        replay2.sink { (state) in

        }.store(in: &subscriptions)

        // State 3

        let relay3 = exampleClass.$state3.relay
        let replay3 = relay3
            .print("DiffStateReplay3")
            .singleReplay()

        replay3.sink { (state) in

        }.store(in: &subscriptions)

        replay3.sink { (state) in

        }.store(in: &subscriptions)

        print("""

        -------------------------------------------------
        All Initial Sink Values should be established ✅
        -------------------------------------------------

        """)

        print("""

        -------------------------------------------------
        Beginning State 1 Modifications
        -------------------------------------------------

        """)

        /**
           State 1 Modifications
        */

        // No modification nothing should print
        exampleClass.state1 = modifiedState

        print("Nothing should have printed 👀")

        // Modify state only change string property and set to state 1
        modifiedState = State(stringProperty: "Hello world", intProperty: 0)
        exampleClass.state1 = modifiedState

        // Should print a change now for state 1

        // Modify state only change int property and set to state 1
        modifiedState = State(stringProperty: "Hello world", intProperty: 10)
        exampleClass.state1 = modifiedState

        // Should print a change now for state 1

        /**
            State 2 Modifications
         */

        print("""

        -------------------------------------------------
        Beginning State 2 Modifications
        -------------------------------------------------

        """)

        // Modify state only change string property and set to state 2
        modifiedState = State(stringProperty: "Hello world", intProperty: 0)
        exampleClass.state2 = modifiedState

        // Nothing should print because we are not diffing on string property

        print("Nothing should have printed 👀")

        // Modify state and this time change int property and set to state 2
        modifiedState = State(stringProperty: "Hello world", intProperty: 10)
        exampleClass.state2 = modifiedState

        // Should print a change now for state 2

        /**
          State 3 Modifications
        */

        print("""

        -------------------------------------------------
        Beginning State 3 Modifications
        -------------------------------------------------

        """)

        // Modify state only change int property and set to state 3
        modifiedState = State(stringProperty: "", intProperty: 10)
        exampleClass.state3 = modifiedState

        // Nothing should print because we are not diffing on int property

        print("Nothing should have printed 👀")

        // Modify state only change int property and set to state 3
        modifiedState = State(stringProperty: "Hello world", intProperty: 10)
        exampleClass.state3 = modifiedState
        
        // Should print a change now for state 3
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
