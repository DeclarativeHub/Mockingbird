//
//  DynamicProperty.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 26/11/2019.
//

public protocol DynamicProperty {
    mutating func update()
}

extension DynamicProperty {
    public func update() {}
}
