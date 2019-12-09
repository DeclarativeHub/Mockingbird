//
//  OffsetModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 24/11/2019.
//

import CoreGraphics

extension ViewModifiers {

    public struct Offset: ViewModifier {

        public let offset: CGSize

        @inlinable
        public init(_ offset: CGSize) {
            self.offset = offset
        }
    }
}

extension View {

    @inlinable
    public func offset(_ offset: CGSize) -> ModifiedContent {
        return modifier(ViewModifiers.Offset(offset))
    }

    @inlinable
    public func offset(x: CGFloat = 0, y: CGFloat = 0) -> ModifiedContent {
        return offset(CGSize(width: x, height: y))
    }
}
