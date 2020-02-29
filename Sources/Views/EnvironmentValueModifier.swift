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

// TODO: Make this a modifier, not a view
public struct EnvironmentValueModifier<Content>: View where Content: View {

    public typealias Body = Swift.Never

    public let content: Content
    public let modify: (inout EnvironmentValues) -> Void

    @inlinable
    public init(content: Content, _ modify: @escaping (inout EnvironmentValues) -> Void) {
        self.content = content
        self.modify = modify
    }
}

extension View {

    @inlinable
    public func environment<V>(_ keyPath: WritableKeyPath<EnvironmentValues, V>, _ value: V) -> EnvironmentValueModifier<Self> {
        return EnvironmentValueModifier(content: self) { $0[keyPath: keyPath] = value }
    }

    @inlinable
    public func environment(_ modify: @escaping (inout EnvironmentValues) -> Void) -> EnvironmentValueModifier<Self> {
        return EnvironmentValueModifier(content: self, modify)
    }
}

extension View {

    @inlinable
    public func foregroundColor(_ color: Color?) -> EnvironmentValueModifier<Self> {
        return environment(\.foregroundColor, color)
    }

//    @inlinable
//    public func zIndex(_ value: Double) -> View {
//        return environment()
//    }

    @inlinable
    public func accentColor(_ accentColor: Color?) -> EnvironmentValueModifier<Self> {
        return environment(\.accentColor, accentColor)
    }

    @inlinable
    public func disabled(_ disabled: Bool) -> EnvironmentValueModifier<Self> {
        return environment(\.isEnabled, !disabled)
    }

//    @inlinable
//    public func opacity(_ opacity: Double) -> View

    @inlinable
    public func font(_ font: Font) -> EnvironmentValueModifier<Self> {
        return environment(\.font, font)
    }

    @inlinable
    public func hidden() -> EnvironmentValueModifier<Self> {
        return environment(\.hidden, true)
    }

    @inlinable
    public func multilineTextAlignment(_ multilineTextAlignment: TextAlignment) -> EnvironmentValueModifier<Self> {
        return environment(\.multilineTextAlignment, multilineTextAlignment)
    }

    @inlinable
    public func truncationMode(_ truncationMode: Text.TruncationMode) -> EnvironmentValueModifier<Self> {
        return environment(\.truncationMode, truncationMode)
    }

    @inlinable
    public func lineSpacing(_ lineSpacing: CGFloat) -> EnvironmentValueModifier<Self> {
        return environment(\.lineSpacing, lineSpacing)
    }

    @inlinable
    public func allowsTightening(_ allowsTightening: Bool) -> EnvironmentValueModifier<Self> {
        return environment(\.allowsTightening, allowsTightening)
    }

    @inlinable
    public func lineLimit(_ lineLimit: Int?) -> EnvironmentValueModifier<Self> {
        return environment(\.lineLimit, lineLimit)
    }

    @inlinable
    public func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> EnvironmentValueModifier<Self> {
        return environment(\.minimumScaleFactor, minimumScaleFactor)
    }
}
