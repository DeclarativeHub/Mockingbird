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

    /// A VStack layout is just an HStack layout flipped in axis :)
    public struct VStack: LayoutAlgorithm {

        private var hStackLayout: LayoutAlgorithms.HStack

        public init(nodes: [LayoutNode], layout: Layouts.VStack, defaultSpacing: CGFloat) {
            hStackLayout = LayoutAlgorithms.HStack(
                nodes: nodes.map { $0.axisFlipped() },
                layout: .init(alignment: layout.alignment.flipped, spacing: layout.spacing),
                defaultSpacing: defaultSpacing
            )
        }

        public func contentLayout(fittingSize targetSize: CGSize) -> ContentGeometry {
            hStackLayout.contentLayout(
                fittingSize: CGSize(width: targetSize.height, height: targetSize.width)
            ).flipped()
        }
    }
}

private extension ContentGeometry {

    func flipped() -> ContentGeometry {
        .init(
            idealSize: CGSize(width: idealSize.height, height: idealSize.width),
            frames: frames.map {
                CGRect(x: $0.origin.y, y: $0.origin.x, width: $0.size.height, height: $0.size.width)
            }
        )
    }
}

