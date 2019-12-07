//
//  LongPressGesture.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 07/12/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import CoreGraphics

public struct LongPressGesture: Gesture {

    public typealias Value = Bool

    public var minimumDuration: Double
    public var maximumDistance: CGFloat

    public init(minimumDuration: Double = 0.5, maximumDistance: CGFloat = 10) {
        self.minimumDuration = minimumDuration
        self.maximumDistance = maximumDistance
    }
}

extension View {

    public func onLongPressGesture(minimumDuration: Double = 0.5, maximumDistance: CGFloat = 10, perform action: @escaping () -> Void) -> ModifiedContent {
        return gesture(LongPressGesture(minimumDuration: minimumDuration, maximumDistance: maximumDistance)
            .onEnded { pressing in
                if !pressing {
                    action()
                }
            })
    }
}
