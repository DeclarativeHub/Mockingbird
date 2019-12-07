//
//  Gesture.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 07/12/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

public protocol AnyGesture {}

public protocol Gesture: AnyGesture {

    /// The type of value produced by this gesture.
    associatedtype Value
}

extension Gesture {

    public func onEnded(_ action: @escaping (Self.Value) -> Void) -> EndedGesture<Self> {
        return EndedGesture(self, action: action)
    }
}
