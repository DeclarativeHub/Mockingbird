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

@propertyWrapper @dynamicMemberLookup
public struct Binding<Value>: DynamicProperty {

    public let get: () -> Value
    public let set: (Value, Transaction) -> Void

    public var transaction: Transaction = Transaction()

    @inlinable
    public init(get: @escaping () -> Value, set: @escaping (Value) -> Void) {
        self.get = get
        self.set = { (value, _) in set(value) }
    }

    @inlinable
    public init(get: @escaping () -> Value, set: @escaping (Value, Transaction) -> Void) {
        self.get = get
        self.set = set
    }

    @inlinable
    public static func constant(_ value: Value) -> Binding<Value> {
        return .init(get: { value }, set: { _ in })
    }

    @inlinable
    public var wrappedValue: Value {
        get {
            return get()
        }
        nonmutating set {
            set(newValue, transaction)
        }
    }

    @inlinable
    public subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Value, Subject>) -> Binding<Subject> {
        return Binding<Subject>(
            get: { self.wrappedValue[keyPath: keyPath] },
            set: { (value, transaction) in self.wrappedValue[keyPath: keyPath] = value }
        )
    }
}

//extension Binding {
//
//    public init<V>(_ base: Binding<V>) where Value == V?
//
//    public init?(_ base: Binding<Value?>)
//
//    public init<V>(_ base: Binding<V>) where Value == AnyHashable, V : Hashable
//}

extension Binding {

    @inlinable
    public func transaction(_ transaction: Transaction) -> Binding<Value> {
        var copy = self
        copy.transaction = transaction
        return copy
    }

    @inlinable
    public func animation(_ animation: Animation? = .default) -> Binding<Value> {
        var copy = self
        copy.transaction = Transaction(animation: animation)
        return copy
    }
}
