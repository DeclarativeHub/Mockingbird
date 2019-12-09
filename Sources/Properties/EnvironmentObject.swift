//
//  EnvironmentObject.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 26/11/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import Foundation

public protocol EnvironmentObjectProperty: DynamicProperty {
    var storage: EnvironmentObjectStorage { get }
}

@propertyWrapper
public struct EnvironmentObject<ObjectType>: EnvironmentObjectProperty {

    public let storage = EnvironmentObjectStorage(
        objectTypeIdentifier: String(reflecting: ObjectType.self),
        get: { fatalError() },
        set: { _ in }
    )

    @inlinable
    public var wrappedValue: ObjectType {
        get {
            return storage.get() as! ObjectType
        }
        set {
            storage.set(newValue)
        }
    }

    public init() {}
}

public class EnvironmentObjectStorage {

    public var get: () -> Any
    public var set: (Any) -> Void
    public let objectTypeIdentifier: String

    @inlinable
    public init(objectTypeIdentifier: String, get: @escaping () -> Any, set: @escaping (Any) -> Void) {
        self.get = get
        self.set = set
        self.objectTypeIdentifier = objectTypeIdentifier
    }
}
