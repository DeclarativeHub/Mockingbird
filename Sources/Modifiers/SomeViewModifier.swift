//
//  SomeViewModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 31/05/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

public protocol SomeViewModifier {

    static var typeIdentifier: String { get }

    func body(content: SomeView) -> SomeView
}
