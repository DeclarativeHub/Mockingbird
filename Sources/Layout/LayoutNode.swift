//
//  Layout.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 16/11/2019.
//

import CoreGraphics

public protocol LayoutNode {
    func isSpacer() -> Bool
    func layoutPriority() -> Double
    func layoutSize(fitting targetSize: CGSize) -> CGSize
}

extension LayoutNode {

    public func axisFlipped() -> LayoutNode {
        return AxisFlippedLayoutNode(layoutNode: self)
    }
}

private struct AxisFlippedLayoutNode: LayoutNode {

    let layoutNode: LayoutNode

    func isSpacer() -> Bool {
        return layoutNode.isSpacer()
    }

    func layoutPriority() -> Double {
        return layoutNode.layoutPriority()
    }

    func layoutSize(fitting targetSize: CGSize) -> CGSize {
        let targetSize = CGSize(width: targetSize.height, height: targetSize.width)
        let size = layoutNode.layoutSize(fitting: targetSize)
        return CGSize(width: size.height, height: size.width)
    }
}
