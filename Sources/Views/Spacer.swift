//
//  Spacer.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

import CoreGraphics

public struct Spacer: View, Equatable {

    public let minLength: CGFloat?

    @inlinable
    public init(minLength: CGFloat? = nil) {
        self.minLength = minLength
    }

    public var body: View {
        fatalError()
    }
}
