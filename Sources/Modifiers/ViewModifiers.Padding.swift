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

    public struct Padding: ViewModifier, Layout {

        public let top: CGFloat?
        public let bottom: CGFloat?
        public let leading: CGFloat?
        public let trailing: CGFloat?

        @inlinable
        public init(top: CGFloat?, bottom: CGFloat?, leading: CGFloat?, trailing: CGFloat?) {
            self.top = top
            self.bottom = bottom
            self.leading = leading
            self.trailing = trailing
        }

        @inlinable
        public init(_ insets: EdgeInsets) {
            (top, bottom, leading, trailing) = (insets.top, insets.bottom, insets.leading, insets.trailing)
        }

        @inlinable
        public init(_ insets: CGFloat?) {
            (top, bottom, leading, trailing) = (insets, insets, insets, insets)
        }

        public func layoutAlgorithm(nodes: [LayoutNode], env: EnvironmentValues) -> LayoutAlgorithm {
            return LayoutAlgorithms.Padding(padding: self, node: nodes.first!, defaultPadding: env.padding)
        }
    }
}

extension View {

    @inlinable
    public func padding(_ insets: EdgeInsets) -> ModifiedContent<Self, ViewModifiers.Padding> {
        return modifier(ViewModifiers.Padding(insets))
    }

    @inlinable
    public func padding(_ insets: CGFloat? = nil) -> ModifiedContent<Self, ViewModifiers.Padding> {
        return modifier(ViewModifiers.Padding(insets))
    }

    @inlinable
    public func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> ModifiedContent<Self, ViewModifiers.Padding> {
        return modifier(ViewModifiers.Padding(
            top: edges.contains(.top) ? length : 0,
            bottom: edges.contains(.bottom) ? length : 0,
            leading: edges.contains(.leading) ? length : 0,
            trailing: edges.contains(.trailing) ? length : 0))
    }
}
