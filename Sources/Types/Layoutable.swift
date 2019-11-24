//
//  Layout.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 16/11/2019.
//

import CoreGraphics

public protocol Layoutable {
    func isSpacer() -> Bool
    func layoutPriority() -> Double
    func layoutSize(fitting targetSize: CGSize) -> CGSize
}

extension Layoutable {

    public func axisFlipped() -> Layoutable {
        return AxisFlippedLayoutable(layoutable: self)
    }
}

private struct AxisFlippedLayoutable: Layoutable {

    let layoutable: Layoutable

    func isSpacer() -> Bool {
        return layoutable.isSpacer()
    }

    func layoutPriority() -> Double {
        return layoutable.layoutPriority()
    }

    func layoutSize(fitting targetSize: CGSize) -> CGSize {
        let targetSize = CGSize(width: targetSize.height, height: targetSize.width)
        let size = layoutable.layoutSize(fitting: targetSize)
        return CGSize(width: size.height, height: size.width)
    }
}
