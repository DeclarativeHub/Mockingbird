//
//  TapGesture.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 07/12/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

public struct TapGesture: Gesture {

    public typealias Value = ()

    public var count: Int

    public init(count: Int = 1) {
        self.count = count
    }
}

extension View {

    public func onTapGesture(count: Int = 1, perform action: @escaping () -> Void) -> ModifiedContent {
        return gesture(TapGesture(count: count).onEnded(action))
    }
}
