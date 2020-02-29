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

extension LayoutAlgorithm {

    public struct Padding {

        public let padding: ViewModifiers.Padding

        /// Modified node
        public let node: LayoutNode

        /// Screen scale
        public let screenScale: CGFloat

        public init(padding: ViewModifiers.Padding, node: LayoutNode, screenScale: CGFloat = 2) {
            self.padding = padding
            self.node = node
            self.screenScale = screenScale
        }

        /// Calculate the stack geometry fitting `targetSize` and aligned by `alignment`.
        public func contentLayout(fittingSize targetSize: CGSize, defaultPadding: CGFloat) -> ContentGeometry {

            let insets = EdgeInsets(
                top: padding.top ?? defaultPadding,
                leading: padding.leading ?? defaultPadding,
                bottom: padding.bottom ?? defaultPadding,
                trailing: padding.trailing ?? defaultPadding
            )

            let rect = CGRect(
                x: insets.leading,
                y: insets.top,
                width: targetSize.width - CGFloat(insets.leading + insets.trailing),
                height: targetSize.height - CGFloat(insets.top + insets.bottom)
            )

            let nodeSize = node.layoutSize(fitting: rect.size)

            let idealSize = CGSize(
                width: nodeSize.width + CGFloat(insets.leading + insets.trailing),
                height: nodeSize.height + CGFloat(insets.top + insets.bottom)
            )

            return ContentGeometry(idealSize: idealSize, frames: [rect])
        }
    }
}
