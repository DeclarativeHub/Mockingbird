//
//  Context.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 23/11/2019.
//

import CoreGraphics

public struct Context {

    public var environment: EnvironmentValues = .init()
    
    public var environmentObjects: [String: Any] = [:]

    public var transaction: Transaction = .init()

    public init() {}
}
