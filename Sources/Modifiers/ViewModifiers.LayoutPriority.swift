//
//  LayoutPriorityModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

import CoreGraphics

extension ViewModifiers {
    
    public struct LayoutPriority: ViewModifier {

        public let value: Double

        public init(_ value: Double) {
            self.value = value
        }
    }
}

extension View {

    public func layoutPriority(_ value: Double) -> ModifiedContent {
        return modifier(ViewModifiers.LayoutPriority(value))
    }
}
