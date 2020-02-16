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
