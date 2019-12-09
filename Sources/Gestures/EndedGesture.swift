//
//  EndedGesture.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 07/12/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import Foundation

public struct EndedGesture<G: Gesture>: Gesture {

    public typealias Value = G.Value

    public let gesture: G
    public let action: (Value) -> Void

    @inlinable
    public init(_ gesture: G, action: @escaping (Value) -> Void) {
        self.gesture = gesture
        self.action = action
    }
}
