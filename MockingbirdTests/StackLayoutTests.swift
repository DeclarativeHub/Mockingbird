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

import XCTest
import Mockingbird

class StackLayoutTests: XCTestCase {

    struct TestNode: LayoutNode {

        let _isSpacer: Bool
        let _layoutPriority: Double
        let _layoutSize: (CGSize) -> CGSize

        init(isSpacer: Bool = false, layoutPriority: Double = 0, layoutSize: CGSize) {
            self.init(isSpacer: isSpacer, layoutPriority: layoutPriority, layoutSize: { _ in layoutSize })
        }

        init(isSpacer: Bool = false, layoutPriority: Double = 0, layoutSize: @escaping (CGSize) -> CGSize) {
            self._isSpacer = isSpacer
            self._layoutPriority = layoutPriority
            self._layoutSize = layoutSize
        }

        var isSpacer: Bool {
            _isSpacer
        }

        var layoutPriority: Double {
            _layoutPriority
        }

        func layoutSize(fitting targetSize: CGSize) -> CGSize {
            _layoutSize(targetSize)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            for _ in 0..<100 {
                let nodes = Array(
                    repeating: TestNode(isSpacer: false, layoutPriority: 0, layoutSize: CGSize(width: 1, height: 100)),
                    count: 50
                )
                let layout = LayoutAlgorithms.HStack(nodes: nodes, layout: .init(alignment: .bottom, spacing: 10), defaultSpacing: 10)
                _ = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100))
            }
        }
    }

    func testEquallyFlexibleNodesDistribution() {
        let nodes = [
            TestNode(isSpacer: false, layoutPriority: 0, layoutSize: { $0 }),
            TestNode(isSpacer: false, layoutPriority: 0, layoutSize: { $0 })
        ]
        let layout = LayoutAlgorithms.HStack(nodes: nodes, layout: .init(alignment: .center, spacing: 10), defaultSpacing: 10)
        let result = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100))
        XCTAssertEqual(
            result.frames,
            [
                CGRect(x: 0, y: 0, width: 45, height: 100),
                CGRect(x: 55, y: 0, width: 45, height: 100)
            ]
        )
    }

    func testFixedSizeNodesDistribution() {
        let nodes = [
            TestNode(isSpacer: false, layoutPriority: 0, layoutSize: CGSize(width: 20, height: 50)),
            TestNode(isSpacer: false, layoutPriority: 0, layoutSize: CGSize(width: 30, height: 50))
        ]
        let layout = LayoutAlgorithms.HStack(nodes: nodes, layout: .init(alignment: .center, spacing: 10), defaultSpacing: 10)
        let result = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100))
        XCTAssertEqual(
            result.frames,
            [
                CGRect(x: 0, y: 25, width: 20, height: 50),
                CGRect(x: 30, y: 25, width: 30, height: 50)
            ]
        )
    }

    func testStepSizeNodesDistribution() {
        let nodes = [
            TestNode(isSpacer: false, layoutPriority: 0) { targetSize in
                if targetSize.width < 50 {
                    return CGSize(width: 40, height: 100)
                } else if targetSize.width < 70 {
                    return CGSize(width: 60, height: 100)
                } else {
                    return CGSize(width: 80, height: 100)
                }
            },
            TestNode(isSpacer: false, layoutPriority: 0, layoutSize: CGSize(width: 30, height: 100))
        ]
        let layout = LayoutAlgorithms.HStack(nodes: nodes, layout: .init(alignment: .center, spacing: 10), defaultSpacing: 10)
        let result = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100))
        XCTAssertEqual(
            result.frames,
            [
                CGRect(x: 0, y: 0, width: 60, height: 100),
                CGRect(x: 70, y: 0, width: 30, height: 100)
            ]
        )
    }

    func testLayoutPrioritiesDistribution() {
        let nodes = [
            TestNode(isSpacer: false, layoutPriority: 0, layoutSize: { $0 }),
            TestNode(isSpacer: false, layoutPriority: 1, layoutSize: { $0 })
        ]
        let layout = LayoutAlgorithms.HStack(nodes: nodes, layout: .init(alignment: .center, spacing: 10), defaultSpacing: 10)
        let result = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100))
        XCTAssertEqual(
            result.frames,
            [
                CGRect(x: 0, y: 0, width: 0, height: 100),
                CGRect(x: 10, y: 0, width: 90, height: 100)
            ]
        )
    }
}
