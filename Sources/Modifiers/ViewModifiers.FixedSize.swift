//
//  FixedSizeModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 11/11/2019.
//

extension ViewModifiers {

    public struct FixedSize: ViewModifier {

        public let horizontal: Bool
        public let vertical: Bool

        public init(horizontal: Bool, vertical: Bool) {
            self.horizontal = horizontal
            self.vertical = vertical
        }
    }
}

extension View {

    public func fixedSize(horizontal: Bool = true, vertical: Bool = false) -> ModifiedContent {
        return modifier(ViewModifiers.FixedSize(horizontal: horizontal, vertical: vertical))
    }
}
