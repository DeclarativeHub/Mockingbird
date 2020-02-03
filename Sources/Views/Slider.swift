//
//  Slider.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 03/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import SwiftUI

public struct Slider: View {

    public let value: Binding<Float>
    public let bounds: ClosedRange<Float>
    public let step: Float

    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0...1, step: V = 1) where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
        self.value = Binding(get: { Float(value.get()) }, set: { value.set(V($0), $1) })
        self.bounds = Float(bounds.lowerBound)...Float(bounds.upperBound)
        self.step = Float(step)
    }

    public var body: View {
        fatalError()
    }
}
