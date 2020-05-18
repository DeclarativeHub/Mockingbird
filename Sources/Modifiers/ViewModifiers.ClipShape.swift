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

import CoreGraphics

extension ViewModifiers {

    public struct ClipShape<S: Shape>: ViewModifier {

        public static var typeIdentifier: String {
            "ClipShape<\(S.typeIdentifier)>"
        }

        public let shape: S

        @inlinable
        public init(_ shape: S) {
            self.shape = shape
        }
    }
}

extension View {

    @inlinable
    public func clipShape<S: Shape>(_ shape: S) -> ModifiedContent<Self, ViewModifiers.ClipShape<S>> {
        return modifier(ViewModifiers.ClipShape(shape))
    }

    @inlinable
    public func clipped() -> ModifiedContent<Self, ViewModifiers.ClipShape<Rectangle>> {
        return modifier(ViewModifiers.ClipShape(Rectangle()))
    }

    @inlinable
    public func cornerRadius(_ radius: CGFloat) -> ModifiedContent<Self, ViewModifiers.ClipShape<RoundedRectangle>> {
        return modifier(ViewModifiers.ClipShape(RoundedRectangle(cornerRadius: radius)))
    }
}
