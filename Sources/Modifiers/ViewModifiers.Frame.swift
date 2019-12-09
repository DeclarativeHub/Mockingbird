//
//  FrameModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

import CoreGraphics

extension ViewModifiers {

    public struct Frame: ViewModifier {

        public let width: CGFloat?
        public let height: CGFloat?
        public let alignment: Alignment

        @inlinable
        public init(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) {
            self.width = width
            self.height = height
            self.alignment = alignment
        }
    }
}

extension View {

    @inlinable
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> ModifiedContent {
        return modifier(ViewModifiers.Frame(width: width, height: height, alignment: alignment))
    }
}
