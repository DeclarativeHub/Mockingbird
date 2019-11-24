//
//  ClipShapeModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

import CoreGraphics

extension ViewModifiers {

    public struct ClipShape: ViewModifier {

        public let shape: Shape

        public init(_ shape: Shape) {
            self.shape = shape
        }
    }
}

extension View {

    public func clipShape(_ shape: Shape) -> ModifiedContent {
        return modifier(ViewModifiers.ClipShape(shape))
    }

    public func clipped() -> ModifiedContent {
        return modifier(ViewModifiers.ClipShape(Rectangle()))
    }

    public func cornerRadius(_ radius: CGFloat) -> ModifiedContent {
        return modifier(ViewModifiers.ClipShape(RoundedRectangle(cornerRadius: radius)))
    }
}
