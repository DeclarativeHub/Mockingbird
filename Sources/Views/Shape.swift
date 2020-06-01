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

public protocol Shape: View {

    func path(in rect: CGRect) -> Path
}

extension Shape {

    public static var typeIdentifier: String {
        String(reflecting: self)
    }

    public var body: ShapeView<Self, ForegroundStyle> {
        return ShapeView(shape: self, style: ForegroundStyle())
    }
}

public protocol ShapeStyle {
}

extension ShapeStyle where Self: View, Self.Body == ShapeView<Rectangle, Self> {

    public var body: ShapeView<Rectangle, Self> {
        return ShapeView(shape: Rectangle(), style: self)
    }
}

public struct ForegroundStyle: ShapeStyle {

    @inlinable public init() {}
}

public struct ShapeView<S: Shape, SS: ShapeStyle>: View {

    public typealias Body = Swift.Never

    public let shape: S
    public let style: SS

    @inlinable
    public init(shape: S, style: SS) {
        self.shape = shape
        self.style = style
    }
}

public struct FillShapeStyle: ShapeStyle {

    public let content: ShapeStyle

    @inlinable
    public init(content: ShapeStyle) {
        self.content = content
    }
}

public struct StrokeShapeStyle: ShapeStyle {

    public let content: ShapeStyle
    public let lineWidth: CGFloat

    @inlinable
    public init(content: ShapeStyle, lineWidth: CGFloat) {
        self.content = content
        self.lineWidth = lineWidth
    }
}

extension Color: ShapeStyle {}

extension Shape {

    @inlinable
    public func fill<S: ShapeStyle>(_ content: S) -> ShapeView<Self, FillShapeStyle> {
        return ShapeView(shape: self, style: FillShapeStyle(content: content))
    }

    @inlinable
    public func stroke<S: ShapeStyle>(_ content: S, lineWidth: CGFloat = 1) -> ShapeView<Self, StrokeShapeStyle> {
        return ShapeView(shape: self, style: StrokeShapeStyle(content: content, lineWidth: lineWidth))
    }
}

public struct Circle: Shape, Equatable {

    public init() {
    }

    @inlinable
    public func path(in rect: CGRect) -> Path {
        guard !rect.isEmpty else { return Path(CGRect.zero) }
        var rect = rect
        if rect.width < rect.height {
            rect.origin.y = (rect.height - rect.width) / 2
            rect.size.height = rect.width
        } else if rect.width > rect.height {
            rect.origin.x = (rect.width - rect.height) / 2
            rect.size.width = rect.height
        }
        return Path(ellipseIn: rect)
    }
}

public struct Rectangle: Shape, Equatable {

    public init() {
    }

    @inlinable
    public func path(in rect: CGRect) -> Path {
        return Path(rect)
    }
}

public enum RoundedCornerStyle: Hashable {
    case circular
    case continuous
}

public struct RoundedRectangle: Shape, Equatable {

    public var cornerSize: CGSize
    public var style: RoundedCornerStyle

    @inlinable
    public init(cornerSize: CGSize, style: RoundedCornerStyle = .circular) {
        self.cornerSize = cornerSize
        self.style = style
    }

    @inlinable
    public init(cornerRadius: CGFloat, style: RoundedCornerStyle = .circular) {
        self.cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        self.style = style
    }

    @inlinable
    public func path(in rect: CGRect) -> Path {
        guard rect.width >= cornerSize.width * 2 else { return Path(CGRect.zero) }
        guard rect.height >= cornerSize.height * 2 else { return Path(CGRect.zero) }
        return Path(roundedRect: rect, cornerSize: cornerSize)
    }
}

public struct Capsule: Shape, Equatable {

    public var style: RoundedCornerStyle

    @inlinable
    public init(style: RoundedCornerStyle = .circular) {
        self.style = style
    }

    @inlinable
    public func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        guard rect.width >= radius * 2 else { return Path(CGRect.zero) }
        guard rect.height >= radius * 2 else { return Path(CGRect.zero) }
        return Path(roundedRect: rect, cornerRadius: radius)
    }
}
