//
//  ModifierContent.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

public struct ModifiedContent: View {

    public var content: View
    public var modifier: ViewModifier

    @inlinable
    public init(content: View, modifier: ViewModifier) {
        self.content = content
        self.modifier = modifier
    }

    public var body: View {
        fatalError()
    }
}

extension View {

    @inlinable
    public func modifier(_ modifier: ViewModifier) -> ModifiedContent {
        return ModifiedContent(content: self, modifier: modifier)
    }
}
