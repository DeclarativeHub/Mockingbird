//
//  Transaction.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 23/11/2019.
//

import CoreGraphics

public struct Transaction {

    public init() {}

    @inlinable
    public init(animation: Animation?) {
        self.animation = animation
    }

    public var animation: Animation?

    public var disablesAnimations: Bool = false
}
