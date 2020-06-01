//
//  ViewModifiers.AspectRatio.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 31/05/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

extension ViewModifiers {

    public struct AspectRatio: ViewModifier {

        public let aspectRatio: CGFloat?
        public let contentMode: ContentMode

        @inlinable
        public init(_ aspectRatio: CGFloat?, contentMode: ContentMode) {
            self.aspectRatio = aspectRatio
            self.contentMode = contentMode
        }
    }
}

extension View {

    @inlinable public func aspectRatio(_ aspectRatio: CGFloat? = nil, contentMode: ContentMode) -> ModifiedContent<Self, ViewModifiers.AspectRatio> {
        modifier(ViewModifiers.AspectRatio(aspectRatio, contentMode: contentMode))
    }

    @inlinable public func aspectRatio(_ aspectRatio: CGSize, contentMode: ContentMode) -> ModifiedContent<Self, ViewModifiers.AspectRatio> {
        modifier(ViewModifiers.AspectRatio(aspectRatio.width / aspectRatio.height, contentMode: contentMode))
    }

    @inlinable public func scaledToFit() -> ModifiedContent<Self, ViewModifiers.AspectRatio> {
        aspectRatio(contentMode: .fit)
    }

    @inlinable public func scaledToFill() -> ModifiedContent<Self, ViewModifiers.AspectRatio> {
        aspectRatio(contentMode: .fill)
    }

}
