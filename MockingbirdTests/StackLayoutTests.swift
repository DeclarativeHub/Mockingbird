//
//  MockingbirdTests.swift
//  MockingbirdTests
//
//  Created by Srdan Rasic on 08/12/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import XCTest
import Mockingbird

class StackLayoutTests: XCTestCase {

    struct TestNode: Layoutable {

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

        func isSpacer() -> Bool {
            _isSpacer
        }

        func layoutPriority() -> Double {
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
                let layout = StackLayout(node: nodes, interItemSpacing: 10)
                _ = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100), alignment: .center)
            }
        }
    }

    func testEquallyFlexibleNodesDistribution() {
        let nodes = [
            TestNode(isSpacer: false, layoutPriority: 0, layoutSize: { $0 }),
            TestNode(isSpacer: false, layoutPriority: 0, layoutSize: { $0 })
        ]
        let layout = StackLayout(node: nodes, interItemSpacing: 10)
        let result = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100), alignment: .center)
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
        let layout = StackLayout(node: nodes, interItemSpacing: 10)
        let result = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100), alignment: .center)
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
        let layout = StackLayout(node: nodes, interItemSpacing: 10)
        let result = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100), alignment: .center)
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
        let layout = StackLayout(node: nodes, interItemSpacing: 10)
        let result = layout.contentLayout(fittingSize: CGSize(width: 100, height: 100), alignment: .center)
        XCTAssertEqual(
            result.frames,
            [
                CGRect(x: 0, y: 0, width: 0, height: 100),
                CGRect(x: 10, y: 0, width: 90, height: 100)
            ]
        )
    }
}
