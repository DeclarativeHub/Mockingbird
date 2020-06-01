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

extension ViewModifiers {

    public struct FlexFrame: ViewModifier, Layout {

        public let minWidth: CGFloat?
        public let idealWidth: CGFloat?
        public let maxWidth: CGFloat?

        public let minHeight: CGFloat?
        public let idealHeight: CGFloat?
        public let maxHeight: CGFloat?

        public let alignment: Alignment

        @inlinable
        public init(minWidth: CGFloat?, idealWidth: CGFloat?, maxWidth: CGFloat?, minHeight: CGFloat?, idealHeight: CGFloat?, maxHeight: CGFloat?, alignment: Alignment) {
            self.minWidth = minWidth
            self.idealWidth = idealWidth
            self.maxWidth = maxWidth
            self.minHeight = minHeight
            self.idealHeight = idealHeight
            self.maxHeight = maxHeight
            self.alignment = alignment
        }

        public func layoutAlgorithm(nodes: [LayoutNode], env: EnvironmentValues) -> LayoutAlgorithm {
            return LayoutAlgorithms.FlexFrame(flexFrame: self, node: nodes.first!)
        }
    }
}

extension View {

    @inlinable
    public func frame(minWidth: CGFloat? = nil, idealWidth: CGFloat? = nil, maxWidth: CGFloat? = nil, minHeight: CGFloat? = nil, idealHeight: CGFloat? = nil, maxHeight: CGFloat? = nil, alignment: Alignment = .center) -> ModifiedContent<Self, ViewModifiers.FlexFrame> {
        return modifier(ViewModifiers.FlexFrame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment))
    }
}
