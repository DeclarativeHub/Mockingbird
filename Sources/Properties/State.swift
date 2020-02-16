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

public protocol StateProperty: DynamicProperty {
    var storage: StateStorage { get }
}

@propertyWrapper public struct State<Value>: StateProperty {

    public let storage: StateStorage

    @inlinable
    public init(wrappedValue value: Value) {
        self.storage = StateStorage(initialValue: value, get: { value }, set: { _ in })
    }

    @inlinable
    public var wrappedValue: Value {
        get {
            storage.get() as! Value
        }
        nonmutating set {
            storage.set(newValue)
        }
    }

    @inlinable
    public var projectedValue: Binding<Value> {
        return Binding(get: { self.wrappedValue }, set: { (value, transaction) in self.wrappedValue = value })
    }
}

extension State where Value: ExpressibleByNilLiteral {

    @inlinable
    public init() {
        self.init(wrappedValue: nil)
    }
}

public class StateStorage {

    public var initialValue: Any
    public var get: () -> Any
    public var set: (Any) -> Void

    @inlinable
    public init(initialValue: Any, get: @escaping () -> Any, set: @escaping (Any) -> Void) {
        self.initialValue = initialValue
        self.get = get
        self.set = set
    }
}
