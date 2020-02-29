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

import Foundation

public struct Color: View {

    public typealias Body = Swift.Never

    public enum Storage: Hashable {
        case rgba(red: Double, green: Double, blue: Double, alpha: Double)
        case asset(name: String, bundle: Bundle?)
    }

    public let storage: Storage

    @inlinable
    public init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.storage = .rgba(red: red, green: green, blue: blue, alpha: alpha)
    }
    @inlinable

    public init(white: Double, opacity: Double) {
        self.init(red: white, green: white, blue: white, alpha: opacity)
    }

    @inlinable
    public init(rgb: Int32, alpha: Double = 1.0) {
        self.init(
            red: Double((rgb >> 16) & 0xff) / 255.0,
            green: Double((rgb >> 8) & 0xff) / 255.0,
            blue: Double(rgb & 0xff) / 255.0,
            alpha: Double(alpha)
        )
    }

    @inlinable
    public init(_ name: String, bundle: Bundle? = nil) {
        self.storage = .asset(name: name, bundle: bundle)
    }

    public static let clear: Color = .init(red: 0, green: 0, blue: 0, alpha: 0)

    public static let black: Color = .init(red: 0, green: 0, blue: 0, alpha: 1)

    public static let white: Color = .init(red: 1, green: 1, blue: 1, alpha: 1)

    public static let gray: Color = .init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)

    public static let red: Color = .init(red: 1, green: 0, blue: 0, alpha: 1)

    public static let green: Color = .init(red: 0, green: 1, blue: 0, alpha: 1)

    public static let blue: Color = .init(red: 0, green: 0, blue: 1, alpha: 1)

    public static let orange: Color = .init(red: 1, green: 0.5, blue: 0, alpha: 1)

    public static let yellow: Color = .init(red: 1, green: 1, blue: 0, alpha: 1)

    public static let pink: Color = .init(red: 1, green: 0, blue: 1, alpha: 1)

    public static let purple: Color = .init(red: 1, green: 0, blue: 1, alpha: 1)

    @inlinable
    public func opacity(_ alpha: Double) -> Color {
        switch storage {
        case .rgba(let red, let green, let blue, let oldAlpha):
            return Color(red: red, green: green, blue: blue, alpha: oldAlpha * alpha)
        default:
            return self // TODO
        }
    }
}

extension Color: Hashable {

    @inlinable
    public static func == (lhs: Color, rhs: Color) -> Bool {
        switch (lhs.storage, rhs.storage) {
        case (.rgba(let lr, let lg, let lb, let la), .rgba(let rr, let rg, let rb, let ra)):
            return lr == rr && lg == rg && lb == rb && la == ra
        case (.asset(let lName, let lBundle), .asset(let rName, let rBundle)):
            return lName == rName && lBundle == rBundle
        default:
            return false
        }
    }

    @inlinable
    public func hash(into hasher: inout Hasher) {
        switch storage {
        case .rgba(let red, let green, let blue, let alpha):
            hasher.combine(red)
            hasher.combine(green)
            hasher.combine(blue)
            hasher.combine(alpha)
        case .asset(let name, let bundle):
            hasher.combine(name)
            hasher.combine(bundle)
        }
    }
}
