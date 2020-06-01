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
