//
//  Optional.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

extension Optional: SomeView where Wrapped: SomeView {

    public var body: SomeView {
        fatalError()
    }
}

extension Optional: View where Wrapped: View {

    public typealias Body = Swift.Never
}
