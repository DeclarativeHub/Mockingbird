// MIT License
//
// Copyright (c) 2020 Declarative Hub
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
