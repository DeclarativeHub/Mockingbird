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

extension Layout {

    /// A VStack layout is just an HStack layout flipped in axis :)
    public struct VStack {

        private var hStackLayout: Layout.HStack

        public var nodes: [LayoutNode] {
            hStackLayout.nodes
        }

        public var interItemSpacing: CGFloat {
            hStackLayout.interItemSpacing
        }

        public var screenScale: CGFloat {
            hStackLayout.screenScale
        }

        public init(nodes: [LayoutNode], interItemSpacing: CGFloat, screenScale: CGFloat = 2) {
            hStackLayout = Layout.HStack(
                nodes: nodes.map { $0.axisFlipped() },
                interItemSpacing: interItemSpacing,
                screenScale: screenScale
            )
        }

        public func contentLayout(fittingSize targetSize: CGSize, alignment: HorizontalAlignment) -> ContentGeometry {
            hStackLayout.contentLayout(
                fittingSize: CGSize(width: targetSize.height, height: targetSize.width),
                alignment: alignment.flipped
            ).flipped()
        }
    }
}

private extension ContentGeometry {

    func flipped() -> ContentGeometry {
        .init(
            idealSize: CGSize(width: idealSize.height, height: idealSize.width),
            frames: frames.map {
                CGRect(x: $0.minY, y: $0.minX, width: $0.height, height: $0.width)
            }
        )
    }
}

