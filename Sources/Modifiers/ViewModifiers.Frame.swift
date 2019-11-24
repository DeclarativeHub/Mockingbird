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

        public init(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) {
            self.width = width
            self.height = height
            self.alignment = alignment
        }
    }
}

extension View {

    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> ModifiedContent {
        return modifier(ViewModifiers.Frame(width: width, height: height, alignment: alignment))
    }
}
