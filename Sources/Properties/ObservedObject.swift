//
//  ObservedObject.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 07/12/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import ReactiveKit

public protocol ObservedObjectProperty: DynamicProperty {
    var objectWillChange: Signal<Void, Never> { get }
}

@propertyWrapper
public struct ObservedObject<ObjectType>: ObservedObjectProperty where ObjectType: ReactiveKit.ObservableObject {

    /// A wrapper of the underlying `ObservableObject` that can create
    /// `Binding`s to its properties using dynamic member lookup.
    @dynamicMemberLookup
    public struct Wrapper {

        var value: ObjectType

        public subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<ObjectType, Subject>) -> Binding<Subject> {
            get {
                return Binding(
                    get: { self.value[keyPath: keyPath] },
                    set: { self.value[keyPath: keyPath] = $0 }
                )
            }
        }
    }

    public init(initialValue: ObjectType) {
        self.projectedValue = Wrapper(value: initialValue)
    }

    public init(wrappedValue: ObjectType) {
        self.projectedValue = Wrapper(value: wrappedValue)
    }

    public var wrappedValue: ObjectType {
        get {
            return projectedValue.value
        }
        set {
            projectedValue.value = newValue
        }
    }

    public var projectedValue: ObservedObject<ObjectType>.Wrapper

    public var objectWillChange: Signal<Void, Never> {
        return wrappedValue.objectWillChange.eraseType().toSignal()
    }
}
