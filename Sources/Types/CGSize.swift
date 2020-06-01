//
//  Size.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 01/06/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

#if canImport(CoreGraphics)

import CoreGraphics

public typealias CGSize = CoreGraphics.CGSize

#else

public struct CGSize: Equatable {

    public static let zero = CGSize(width: 0, height: 0)

    public var width: CGFloat
    public var height: CGFloat

    @inlinable
    public init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
}

#endif
