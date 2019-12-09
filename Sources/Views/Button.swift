//
//  Button.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

public struct Button: View {

    public let label: View
    public let action: () -> Void

    @inlinable
    public init(action: @escaping () -> Void, @ViewBuilder makeLabel: () -> View) {
        self.action = action
        self.label = makeLabel()
    }

    public var body: View {
        fatalError()
    }
}

extension Button {

    @inlinable
    public init(_ title: String, action:  @escaping () -> Void) {
        self.action = action
        self.label = Text(title)
    }
}
