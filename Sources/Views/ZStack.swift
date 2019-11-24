//
//  ZStack.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

public struct ZStack: View {

    public let content: [View]
    public let alignment: Alignment

    public init(alignment: Alignment = .center, @ViewBuilder makeContent: () -> View) {
        self.content = makeContent().flattened
        self.alignment = alignment
    }

    public var body: View {
        fatalError()
    }
}

extension ZStack: Equatable {

    public static func == (lhs: ZStack, rhs: ZStack) -> Bool {
        return lhs.alignment == rhs.alignment
    }
}
