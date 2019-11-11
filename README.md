#  DiffValue
[![Build Status](https://travis-ci.com/ZkHaider/DiffValue.svg?branch=master)](https://travis-ci.com/ZkHaider/DiffValue) ![Platforms](https://img.shields.io/badge/platform-iOS%20%7C%20MacOS%20%7C%20tvOS%20%7C%20watchOS-brightgreen) ![Swift Version](https://img.shields.io/badge/swift-5.1-blue)

<p align="center">
    <img src="https://raw.githubusercontent.com/ZkHaider/DiffValue/master/.github/Assets/diffvalue_title.png" alt="DiffValue by ZkHaider" />
</p>

#

DiffValue is a property observation tool that utilizes automatic diffing on properties through Combine and Property Wrappers. 

#

## Installation

DiffValue is available via Carthage, just add to your Cartfile like so:

```shell
$ github "ZkHaider/DiffValue" "master"
```

```shell 
$ carthage update DiffValue
```

## Usage 

It's easy to observe only properties you are interested in, you can do so like this:

```swift 
struct UserState {
    let userName: String 
    let email: String
    let password: String
}

extension UserState: EquatableWithIdentity {
    /// Default value
    static var identity: UserState {
        UserState(
            userName: "",
            email: String,
            password: String
        )
    }
}

final class ViewController: UIViewController {

    // MARK: - State
    
    @Diff(\.userName, \.email)
    var userState; UserState 
    
    // MARK: - Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        // Start listening to state changes 
        // This is only called when your specified key paths are updated
        let subscription = $userState.sink { state in 
            print("Listening to state changes: \(state)")
        }
    }

}
```

That's it! Use `KeyPath` to specify which properties you are interested in. You can optionally choose to conform to `EquatableWithIdentity`, however any value that you want to be utilized by `@Diff` needs to be `Equatable`. If you opt out of `EquatableWithIdentity` you will have to pass a default value in the property wrapper:

```swift 
struct UserState {
    let userName: String 
    let email: String
    let password: String
}

final class ViewController: UIViewController {

    // MARK: - State
    
    @Diff(
        value: UserState(userName: "", email: "", password: ""),
        \.userName, 
        \.email
    )
    var userState; UserState 
    
    // MARK: - Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        // Start listening to state changes 
        // This is only called when your specified key paths are updated
        let subscription = $userState.sink { state in 
            print("Listening to state changes: \(state)")
        }
    }

}
```

If no `KeyPath<Root, Value>` are passed into the `@Diff` wrapper it will just do an equality check like normal based on `Equatable`:

```swift 
struct UserState {
    let userName: String 
    let email: String
    let password: String
}

final class ViewController: UIViewController {

    // MARK: - State
    
    @Diff()
    var userState; UserState 
    
    // MARK: - Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        // Start listening to state changes 
        // This is only called when your specified key paths are updated
        // Invoked via equatable if we detect any changes because 
        // we did not pass in any keypaths
        let subscription = $userState.sink { state in 
            print("Listening to state changes: \(state)")
        }
    }

}
```

`DiffValue` supports passing up to `10 KeyPath<Root, Value>` parameters in the initializer, if you require more you will have to pass an array of `DiffableKeyPath<Root>` types like:

```swift
struct MyVeryLargeState {
    let property1: String 
    let property2: String
    let property3: String
    let property4: String
    let property5: String
    let property6: String
    let property7: String
    let property8: String
    let property9: String
    let property10: String
    let property11: String
    let property12: String
}

extension MyVeryLargeState: EquatableWithIdentity {
    /// Default value
    static var identity: MyVeryLargeState {
        MyVeryLargeState(
            property1: "", 
            property2: "",
            property3: "",
            property4: "",
            property5: "",
            property6: "",
            property7: "",
            property8: "",
            property9: "",
            property10: "",
            property11: "",
            property12: ""
        )
    }
}

final class ViewController: UIViewController {

    // MARK: - State
    
    @Diff(keyPaths: 
        (\MyVeryLargeState.property1).diffable, 
        (\MyVeryLargeState.property2).diffable,
        (\MyVeryLargeState.property3).diffable,
        (\MyVeryLargeState.property4).diffable,
        (\MyVeryLargeState.property5).diffable,
        (\MyVeryLargeState.property6).diffable,
        (\MyVeryLargeState.property7).diffable,
        (\MyVeryLargeState.property8).diffable,
        (\MyVeryLargeState.property9).diffable,
        (\MyVeryLargeState.property10).diffable,
        (\MyVeryLargeState.property11).diffable,
        (\MyVeryLargeState.property12).diffable,
    )
    var largeState; MyVeryLargeState 
    
    // MARK: - Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }

}
```

Chances are if the  `State` encapsulates a large set of properties it probably needs to be divided up -- always keep your `State` lightweight! However this library does support as many `KeyPath<Root, Value>`s as you wish to diff on!

A `@Diff` property wrapper exposes a `CurrentValueRelay<Root, Never>`. This is a `Publisher` with a private `CurrentValueSubject<Root, Never>` field. This is hidden so you cannot pass a `completion` event to the `Relay`. Use the `Relay` to subscribe your `State` to other `Subscribers`! Here is fully fledged example:

```swift 
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

var modifiedState = State(stringProperty: "", intProperty: 0)

/// Setup subscriptions

// State 1

let relay1 = exampleClass.$state1
let replay1 = relay1
    .print("DiffStateReplay1")
    .singleReplay()

replay1.sink { (state) in
    
}.store(in: &subscriptions)

replay1.sink { (state) in
    
}.store(in: &subscriptions)

// State 2

let relay2 = exampleClass.$state2
let replay2 = relay2
    .print("DiffStateReplay2")
    .singleReplay()

replay2.sink { (state) in
    
}.store(in: &subscriptions)

replay2.sink { (state) in
    
}.store(in: &subscriptions)

// State 3

let relay3 = exampleClass.$state3
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

/***

Print Output:
 
 DiffStateReplay1: receive subscription: (CurrentValueSubject)
 DiffStateReplay1: request unlimited
 DiffStateReplay1: receive value: (State(stringProperty: "", intProperty: 0))
 DiffStateReplay2: receive subscription: (CurrentValueSubject)
 DiffStateReplay2: request unlimited
 DiffStateReplay2: receive value: (State(stringProperty: "", intProperty: 0))
 DiffStateReplay3: receive subscription: (CurrentValueSubject)
 DiffStateReplay3: request unlimited
 DiffStateReplay3: receive value: (State(stringProperty: "", intProperty: 0))

 -------------------------------------------------
 All Initial Sink Values should be established ✅
 -------------------------------------------------


 -------------------------------------------------
 Beginning State 1 Modifications
 -------------------------------------------------

 Nothing should have printed 👀
 DiffStateReplay1: receive value: (State(stringProperty: "Hello world", intProperty: 0))
 DiffStateReplay1: receive value: (State(stringProperty: "Hello world", intProperty: 10))

 -------------------------------------------------
 Beginning State 2 Modifications
 -------------------------------------------------

 Nothing should have printed 👀
 DiffStateReplay2: receive value: (State(stringProperty: "Hello world", intProperty: 10))

 -------------------------------------------------
 Beginning State 3 Modifications
 -------------------------------------------------

 Nothing should have printed 👀
 DiffStateReplay3: receive value: (State(stringProperty: "Hello world", intProperty: 10))
 
 */
```

If you like the library please star it 🙂
