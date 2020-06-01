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

    public struct Frame: LayoutAlgorithm {

        public let frame: ViewModifiers.Frame

        /// Modified node
        public let node: LayoutNode

        /// Screen scale
        public let screenScale: CGFloat

        public init(frame: ViewModifiers.Frame, node: LayoutNode, screenScale: CGFloat = 2) {
            self.frame = frame
            self.node = node
            self.screenScale = screenScale
        }

        /// Calculate the stack geometry fitting `targetSize` and aligned by `alignment`.
        public func contentLayout(fittingSize targetSize: CGSize) -> ContentGeometry {
            var targetSize = targetSize
            if let width = frame.width {
                targetSize.width = min(targetSize.width, width)
            }
            if let height = frame.height {
                targetSize.height = min(targetSize.height, height)
            }

            var viewSize = node.layoutSize(fitting: targetSize)
            if let width = frame.width {
                viewSize.width = max(viewSize.width, width)
            }
            if let height = frame.height {
                viewSize.height = max(viewSize.height, height)
            }

            let rect: CGRect
            switch frame.alignment {
            case .center:
                rect = CGRect(
                    x: (targetSize.width - viewSize.width) / 2,
                    y: (targetSize.height - viewSize.height) / 2,
                    width: viewSize.width,
                    height: viewSize.height
                )
            default:
                fatalError("TODO")
            }

            return ContentGeometry(idealSize: rect.size, frames: [rect])
        }
    }
}
