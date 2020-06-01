//
//  TupleView.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

public struct TupleView<T>: View {

    public typealias Body = Swift.Never

    public var value: T

    @inlinable
    public init(_ value: T) {
        self.value = value
    }
}
