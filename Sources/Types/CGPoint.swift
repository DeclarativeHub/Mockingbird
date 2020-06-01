//
//  Point.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 01/06/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

#if canImport(CoreGraphics)

import CoreGraphics

public typealias CGPoint = CoreGraphics.CGPoint

#else

public struct CGPoint: Equatable {

    public static let zero = CGPoint(x: 0, y: 0)

    public var x: CGFloat
    public var y: CGFloat

    @inlinable
    public init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
}

#endif
