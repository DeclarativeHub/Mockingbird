//
//  OverlayModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 24/11/2019.
//

import CoreGraphics

extension ViewModifiers {

    public struct Overlay: ViewModifier {

        public let overlay: View

        public init(_ overlay: View) {
            self.overlay = overlay
        }
    }
}

extension View {

    public func overlay(_ view: View) -> ModifiedContent {
        return modifier(ViewModifiers.Overlay(view))
    }
}
