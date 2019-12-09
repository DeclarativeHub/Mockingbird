//
//  HStack.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//
import CoreGraphics

public struct HStack: View {

    public let content: [View]
    public let alignment: VerticalAlignment
    public let spacing: CGFloat?

    @inlinable
    public init(alignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder makeContent: () -> View) {
        self.content = makeContent().flattened
        self.alignment = alignment
        self.spacing = spacing
    }

    public var body: View {
        fatalError()
    }
}

extension HStack: Equatable {

    @inlinable
    public static func == (lhs: HStack, rhs: HStack) -> Bool {
        return lhs.spacing == rhs.spacing && lhs.alignment == rhs.alignment
    }
}
