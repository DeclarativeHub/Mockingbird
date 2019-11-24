//
//  Modified.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 24/11/2019.
//

func modified<T>(_ value: T, _ modify: (inout T) -> Void) -> T {
    var copy = value
    modify(&copy)
    return copy
}
