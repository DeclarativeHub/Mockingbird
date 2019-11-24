//
//  BackgroundModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 24/11/2019.
//

import CoreGraphics

extension ViewModifiers {

    public struct Background: ViewModifier {

        public let background: View

        public init(_ background: View) {
            self.background = background
        }
    }
}

extension View {

    public func background(_ view: View) -> ModifiedContent {
        return modifier(ViewModifiers.Background(view))
    }
}
