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

import CoreGraphics

public struct EnvironmentValueModifier: View {

    public let content: View
    public let modify: (inout EnvironmentValues) -> Void

    @inlinable
    public init(content: View, _ modify: @escaping (inout EnvironmentValues) -> Void) {
        self.content = content
        self.modify = modify
    }

    public var body: View {
        fatalError()
    }
}

extension View {

    @inlinable
    public func environment<V>(_ keyPath: WritableKeyPath<EnvironmentValues, V>, _ value: V) -> EnvironmentValueModifier {
        return EnvironmentValueModifier(content: self) { $0[keyPath: keyPath] = value }
    }

    @inlinable
    public func environment(_ modify: @escaping (inout EnvironmentValues) -> Void) -> EnvironmentValueModifier {
        return EnvironmentValueModifier(content: self, modify)
    }
}

extension View {

    @inlinable
    public func foregroundColor(_ color: Color?) -> EnvironmentValueModifier {
        return environment(\.foregroundColor, color)
    }

//    @inlinable
//    public func zIndex(_ value: Double) -> View {
//        return environment()
//    }

    @inlinable
    public func accentColor(_ accentColor: Color?) -> EnvironmentValueModifier {
        return environment(\.accentColor, accentColor)
    }

    @inlinable
    public func disabled(_ disabled: Bool) -> EnvironmentValueModifier {
        return environment(\.isEnabled, !disabled)
    }

//    @inlinable
//    public func opacity(_ opacity: Double) -> View

    @inlinable
    public func font(_ font: Font) -> EnvironmentValueModifier {
        return environment(\.font, font)
    }

    @inlinable
    public func hidden() -> EnvironmentValueModifier {
        return environment(\.hidden, true)
    }

    @inlinable
    public func multilineTextAlignment(_ multilineTextAlignment: TextAlignment) -> EnvironmentValueModifier {
        return environment(\.multilineTextAlignment, multilineTextAlignment)
    }

    @inlinable
    public func truncationMode(_ truncationMode: Text.TruncationMode) -> EnvironmentValueModifier {
        return environment(\.truncationMode, truncationMode)
    }

    @inlinable
    public func lineSpacing(_ lineSpacing: CGFloat) -> EnvironmentValueModifier {
        return environment(\.lineSpacing, lineSpacing)
    }

    @inlinable
    public func allowsTightening(_ allowsTightening: Bool) -> EnvironmentValueModifier {
        return environment(\.allowsTightening, allowsTightening)
    }

    @inlinable
    public func lineLimit(_ lineLimit: Int?) -> EnvironmentValueModifier {
        return environment(\.lineLimit, lineLimit)
    }

    @inlinable
    public func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> EnvironmentValueModifier {
        return environment(\.minimumScaleFactor, minimumScaleFactor)
    }
}
