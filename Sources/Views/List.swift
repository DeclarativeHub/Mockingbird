//
//  List.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 13/06/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

public struct List<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {

    public typealias Body = Never

    public let content: Content

}

extension List where SelectionValue == Never {

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}
