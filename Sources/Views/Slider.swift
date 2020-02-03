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

    public init(value: Binding<Float>, in bounds: ClosedRange<Float> = 0...1, step: Float = 1) {
        self.value = value
        self.bounds = bounds
        self.step = step
    }

    public var body: View {
        fatalError()
    }
}
