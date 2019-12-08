//
//  CoreGraphics.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 08/12/2019.
//

import CoreGraphics

extension CGFloat {

    @inlinable
    public func roundedToScale(scale: CGFloat, rule: FloatingPointRoundingRule) -> CGFloat {
        let scale: CGFloat = 1.0 / scale
        return scale * (self / scale).rounded(rule)
    }
}

extension CGSize {

    @inlinable
    public func roundedToScale(scale: CGFloat) -> CGSize {
        return CGSize(
            width: width.roundedToScale(scale: scale, rule: .awayFromZero),
            height: height.roundedToScale(scale: scale, rule: .awayFromZero)
        )
    }
}

extension CGPoint {

    @inlinable
    public func roundedToScale(scale: CGFloat) -> CGPoint {
        return CGPoint(
            x: x.roundedToScale(scale: scale, rule: .toNearestOrAwayFromZero),
            y: y.roundedToScale(scale: scale, rule: .toNearestOrAwayFromZero)
        )
    }
}

extension CGRect {

    @inlinable
    public func roundedToScale(scale: CGFloat) -> CGRect {
        return CGRect(
            origin: origin.roundedToScale(scale: scale),
            size: size.roundedToScale(scale: scale)
        )
    }
}
