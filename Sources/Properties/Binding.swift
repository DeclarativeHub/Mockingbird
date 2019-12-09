//
//  Binding.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 26/11/2019.
//

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
        return modified(self) { $0.transaction = transaction }
    }

    @inlinable
    public func animation(_ animation: Animation? = .default) -> Binding<Value> {
        return modified(self) { $0.transaction = Transaction(animation: animation) }
    }
}
