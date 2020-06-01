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

extension LayoutAlgorithms {

    public struct FlexFrame: LayoutAlgorithm {

        public let modifer: ViewModifiers.FlexFrame

        /// Modified node
        public let node: LayoutNode

        /// Screen scale
        public let screenScale: CGFloat

        public init(flexFrame: ViewModifiers.FlexFrame, node: LayoutNode, screenScale: CGFloat = 2) {
            self.modifer = flexFrame
            self.node = node
            self.screenScale = screenScale
        }

        /// Calculate the stack geometry fitting `targetSize` and aligned by `alignment`.
        public func contentLayout(fittingSize targetSize: CGSize) -> ContentGeometry {
            var idealSize = targetSize

            if let minWidth = modifer.minWidth {
                idealSize.width = max(idealSize.width, minWidth)
            }
            if let maxWidth = modifer.maxWidth {
                idealSize.width = min(idealSize.width, maxWidth)
            }
            if let minHeight = modifer.minHeight {
                idealSize.height = max(idealSize.height, minHeight)
            }
            if let maxHeight = modifer.maxHeight {
                idealSize.height = min(idealSize.height, maxHeight)
            }

            var size = node.layoutSize(fitting: idealSize)
            size.width = clamp(idealSize.width, min: modifer.minWidth ?? size.width, max: modifer.maxWidth ?? size.width)
            size.height = clamp(idealSize.height, min: modifer.minHeight ?? size.height, max: modifer.maxHeight ?? size.height)

            let rect: CGRect

            switch modifer.alignment {
            case .center:
                rect = CGRect(
                    x: (idealSize.width - size.width) / 2,
                    y: (idealSize.height - size.height) / 2,
                    width: size.width,
                    height: size.height
                )
            default:
                fatalError("TODO")
            }

            return ContentGeometry(idealSize: idealSize, frames: [rect])
        }
    }
}

private func clamp(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
    return Swift.min(Swift.max(value, min), max)
}
