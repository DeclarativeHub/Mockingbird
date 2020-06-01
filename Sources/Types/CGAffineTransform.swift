//
//  CGAffineTransform.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 01/06/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

#if canImport(CoreGraphics)

import CoreGraphics

public typealias CGAffineTransform = CoreGraphics.CGAffineTransform

#else

public struct CGAffineTransform: Equatable {

    public static let identity = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)

    public var a: CGFloat
    public var b: CGFloat
    public var c: CGFloat
    public var d: CGFloat
    public var tx: CGFloat
    public var ty: CGFloat

    public init(a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, tx: CGFloat, ty: CGFloat) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.tx = tx
        self.ty = ty
    }

    public init(translationX tx: CGFloat, y ty: CGFloat) {
        self.init(a: 1, b: 0, c: 0, d: 1, tx: tx, ty: ty)
    }

    public init(scaleX sx: CGFloat, y sy: CGFloat) {
        self.init(a: sx, b: 0, c: 0, d: sy, tx: 0, ty: 0)
    }

//    public init(rotationAngle angle: CGFloat) {
//        self.init(a: cos(angle), b: sin(angle), c: -sin(angle), d: cos(angle), tx: 0, ty: 0)
//    }

}

extension CGPoint {

    public func applying(_ transform: CGAffineTransform) -> CGPoint {
        CGPoint(
            x: x * transform.a + y * transform.c + transform.tx,
            y: x * transform.b + y * transform.d + transform.ty
        )
    }
}

#endif
