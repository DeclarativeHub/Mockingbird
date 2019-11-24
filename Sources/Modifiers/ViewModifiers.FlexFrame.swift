//
//  FlexFrameModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 17/11/2019.
//

import CoreGraphics

extension ViewModifiers {

    public struct FlexFrame: ViewModifier {

        public let minWidth: CGFloat?
        public let idealWidth: CGFloat?
        public let maxWidth: CGFloat?

        public let minHeight: CGFloat?
        public let idealHeight: CGFloat?
        public let maxHeight: CGFloat?

        public let alignment: Alignment

        public init(minWidth: CGFloat?, idealWidth: CGFloat?, maxWidth: CGFloat?, minHeight: CGFloat?, idealHeight: CGFloat?, maxHeight: CGFloat?, alignment: Alignment) {
            self.minWidth = minWidth
            self.idealWidth = idealWidth
            self.maxWidth = maxWidth
            self.minHeight = minHeight
            self.idealHeight = idealHeight
            self.maxHeight = maxHeight
            self.alignment = alignment
        }
    }
}

extension View {

    public func frame(minWidth: CGFloat? = nil, idealWidth: CGFloat? = nil, maxWidth: CGFloat? = nil, minHeight: CGFloat? = nil, idealHeight: CGFloat? = nil, maxHeight: CGFloat? = nil, alignment: Alignment = .center) -> ModifiedContent {
        return modifier(ViewModifiers.FlexFrame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment))
    }
}
