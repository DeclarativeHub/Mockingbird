//
//  Padding.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 09/11/2019.
//

import CoreGraphics

extension ViewModifiers {

    public struct Padding: ViewModifier {

        public let top: CGFloat?
        public let bottom: CGFloat?
        public let leading: CGFloat?
        public let trailing: CGFloat?

        @inlinable
        public init(top: CGFloat?, bottom: CGFloat?, leading: CGFloat?, trailing: CGFloat?) {
            self.top = top
            self.bottom = bottom
            self.leading = leading
            self.trailing = trailing
        }

        @inlinable
        public init(_ insets: EdgeInsets) {
            (top, bottom, leading, trailing) = (insets.top, insets.bottom, insets.leading, insets.trailing)
        }

        @inlinable
        public init(_ insets: CGFloat?) {
            (top, bottom, leading, trailing) = (insets, insets, insets, insets)
        }
    }
}

extension View {

    @inlinable
    public func padding(_ insets: EdgeInsets) -> ModifiedContent {
        return modifier(ViewModifiers.Padding(insets))
    }

    @inlinable
    public func padding(_ insets: CGFloat? = nil) -> ModifiedContent {
        return modifier(ViewModifiers.Padding(insets))
    }

    @inlinable
    public func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> ModifiedContent {
        return modifier(ViewModifiers.Padding(
            top: edges.contains(.top) ? length : 0,
            bottom: edges.contains(.bottom) ? length : 0,
            leading: edges.contains(.leading) ? length : 0,
            trailing: edges.contains(.trailing) ? length : 0))
    }
}
