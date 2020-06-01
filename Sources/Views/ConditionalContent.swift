//
//  ConditionalContent.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

public struct ConditionalContent<TrueContent: View, FalseContent: View>: View {

    public typealias Body = Swift.Never

    public enum Storage {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }

    public let storage: Storage

    public init(_ trueContent: TrueContent) {
        self.storage = .trueContent(trueContent)
    }

    public init(_ falseContent: FalseContent) {
        self.storage = .falseContent(falseContent)
    }
}
