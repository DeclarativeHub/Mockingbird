//
//  VStack.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

import CoreGraphics

public struct VStack: View {

    public let content: [View]
    public let alignment: HorizontalAlignment
    public let spacing: CGFloat?

    @inlinable
    public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder makeContent: () -> View) {
        self.content = makeContent().flattened
        self.alignment = alignment
        self.spacing = spacing
    }

    public var body: View {
        fatalError()
    }
}

extension VStack: Equatable {

    @inlinable
    public static func == (lhs: VStack, rhs: VStack) -> Bool {
        return lhs.spacing == rhs.spacing && lhs.alignment == rhs.alignment
    }
}
