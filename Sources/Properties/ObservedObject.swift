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

        public var value: ObjectType

        @inlinable
        public init(value: ObjectType) {
            self.value = value
        }

        @inlinable
        public subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<ObjectType, Subject>) -> Binding<Subject> {
            get {
                return Binding(
                    get: { self.value[keyPath: keyPath] },
                    set: { self.value[keyPath: keyPath] = $0 }
                )
            }
        }
    }

    @inlinable
    public init(initialValue: ObjectType) {
        self.projectedValue = Wrapper(value: initialValue)
    }

    @inlinable
    public init(wrappedValue: ObjectType) {
        self.projectedValue = Wrapper(value: wrappedValue)
    }

    @inlinable
    public var wrappedValue: ObjectType {
        get {
            return projectedValue.value
        }
        set {
            projectedValue.value = newValue
        }
    }

    public var projectedValue: ObservedObject<ObjectType>.Wrapper

    @inlinable
    public var objectWillChange: Signal<Void, Never> {
        return wrappedValue.objectWillChange.eraseType().toSignal()
    }
}
