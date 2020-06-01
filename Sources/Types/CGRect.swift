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
