//
//  Sized.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 27/06/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import Foundation

public struct Sized: NodeModifier, Equatable {

    public let width: CGFloat?
    public let height: CGFloat?

    @inlinable public init(width: CGFloat?, height: CGFloat?) {
        self.width = width
        self.height = height
    }
}

extension Node {

    @inlinable public func relativeSize(width: CGFloat, height: CGFloat) -> ModifiedNode<Self, Sized> {
        return modified(Sized(width: width, height: height))
    }

    @inlinable public func relativeWidth(_ width: CGFloat) -> ModifiedNode<Self, Sized> {
        return modified(Sized(width: width, height: nil))
    }

    @inlinable public func relativeHeight(_ height: CGFloat) -> ModifiedNode<Self, Sized> {
        return modified(Sized(width: nil, height: height))
    }
}
