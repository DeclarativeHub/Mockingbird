//
//  Rect.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 09/11/2019.
//

import CoreGraphics

public struct EdgeInsets {

    public var top: CGFloat
    public var leading: CGFloat
    public var bottom: CGFloat
    public var trailing: CGFloat

    @inlinable
    public init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }

    @inlinable
    public init(_ value: CGFloat) {
        self.top = value
        self.leading = value
        self.bottom = value
        self.trailing = value
    }

    @inlinable
    public init() {
        self.top = 0
        self.leading = 0
        self.bottom = 0
        self.trailing = 0
    }

    @inlinable
    public static var zero: EdgeInsets {
        return .init()
    }
}
