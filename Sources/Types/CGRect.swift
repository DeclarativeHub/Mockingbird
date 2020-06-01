//
//  CGRect.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 01/06/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

#if canImport(CoreGraphics)

import CoreGraphics

public typealias CGRect = CoreGraphics.CGRect

#else

public struct CGRect: Equatable {

    public static let zero = CGRect(x: 0, y: 0, width: 0, height: 0)

    public var origin: CGPoint
    public var size: CGSize

    @inlinable
    public var minX: CGFloat {
        origin.x
    }

    @inlinable
    public var minY: CGFloat {
        origin.y
    }

    @inlinable
    public var width: CGFloat {
        size.width
    }

    @inlinable
    public var height: CGFloat {
        size.height
    }

    @inlinable
    public var isEmpty: Bool {
        height == 0 || width == 0
    }

    @inlinable
    public init(origin: CGPoint, size: CGSize) {
        self.origin = origin
        self.size = size
    }

    @inlinable
    public init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.origin = .init(x: x, y: y)
        self.size = .init(width: width, height: height)
    }
}

#endif
