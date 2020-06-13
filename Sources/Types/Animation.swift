// MIT License
//
// Copyright (c) 2020 Declarative Hub
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

public struct Animation {

    public enum Repetition {
        case none
        case count(Int, autoreverses: Bool)
        case forever(autoreverses: Bool)
    }

    public enum Kind {
        case linear(easeIn: Bool, easeOut: Bool)
        case spring(response: Double, dampingFraction: Double, blendDuration: Double)
    }

    public var kind: Kind = .linear(easeIn: false, easeOut: false)
    public var delay: Double = 0
    public var speed: Double = 1
    public var duration: Double = 0.25
    public var repetition: Repetition = .none

    public static let `default`: Animation = Animation()

    public static func spring(response: Double = 0.55, dampingFraction: Double = 0.825, blendDuration: Double = 0) -> Animation {
        Animation(kind: .spring(response: response, dampingFraction: dampingFraction, blendDuration: blendDuration))
    }

    public static func easeInOut(duration: Double) -> Animation {
        Animation(kind: .linear(easeIn: true, easeOut: true), duration: duration)
    }

    public static var easeInOut: Animation {
        .easeInOut(duration: 0.25)
    }

    public static func easeIn(duration: Double) -> Animation {
        Animation(kind: .linear(easeIn: true, easeOut: false), duration: duration)
    }

    public static var easeIn: Animation {
        .easeIn(duration: 0.25)
    }

    public static func easeOut(duration: Double) -> Animation {
        Animation(kind: .linear(easeIn: false, easeOut: true), duration: duration)
    }

    public static var easeOut: Animation {
        .easeOut(duration: 0.25)
    }

    public static func linear(duration: Double) -> Animation {
        Animation(kind: .linear(easeIn: false, easeOut: false), duration: duration)
    }

    public static var linear: Animation {
        .linear(duration: 0.25)
    }
}

extension Animation {

    public func delay(_ delay: Double) -> Animation {
        var copy = self
        copy.delay = delay
        return copy
    }

    public func speed(_ speed: Double) -> Animation {
        var copy = self
        copy.speed = speed
        return copy
    }

    public func repeatCount(_ repeatCount: Int, autoreverses: Bool = true) -> Animation {
        var copy = self
        copy.repetition = .count(repeatCount, autoreverses: autoreverses)
        return copy
    }

    public func repeatForever(autoreverses: Bool = true) -> Animation {
        var copy = self
        copy.repetition = .forever(autoreverses: autoreverses)
        return copy
    }
}
