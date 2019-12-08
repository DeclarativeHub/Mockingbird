//
//  Shape.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

import CoreGraphics

public protocol Shape: View {

    func path(in rect: CGRect) -> CGPath
}

extension Shape {

    public var body: View {
        fatalError()
    }
}

public struct FillShapeView: View {

    public let color: Color
    public let shape: Shape

    public init(_ color: Color, shape: Shape) {
        self.color = color
        self.shape = shape
    }

    public var body: View {
        fatalError()
    }
}

public struct StrokeShapeView: View {

    public let color: Color
    public let shape: Shape
    public let lineWidth: CGFloat

    public init(_ color: Color, shape: Shape, lineWidth: CGFloat) {
        self.color = color
        self.shape = shape
        self.lineWidth = lineWidth
    }

    public var body: View {
        fatalError()
    }
}

extension Shape {

    public func fill(_ color: Color) -> FillShapeView {
        return FillShapeView(color, shape: self)
    }
    
    public func stroke(_ color: Color, lineWidth: CGFloat = 1) -> StrokeShapeView {
        return StrokeShapeView(color, shape: self, lineWidth: lineWidth)
    }
}

public struct Circle: Shape, Equatable {

    public init() {
    }

    public func path(in rect: CGRect) -> CGPath {
        guard !rect.isEmpty else { return CGPath(rect: .zero, transform: nil) }
        var rect = rect
        if rect.width < rect.height {
            rect.origin.y = (rect.height - rect.width) / 2
            rect.size.height = rect.width
        } else if rect.width > rect.height {
            rect.origin.x = (rect.width - rect.height) / 2
            rect.size.width = rect.height
        }
        return CGPath(ellipseIn: rect, transform: nil)
    }
}

public struct Rectangle: Shape, Equatable {

    public init() {
    }

    public func path(in rect: CGRect) -> CGPath {
        return CGPath(rect: rect, transform: nil)
    }
}

public enum RoundedCornerStyle: Hashable {
    case circular
    case continuous
}

public struct RoundedRectangle: Shape, Equatable {

    public var cornerSize: CGSize
    public var style: RoundedCornerStyle

    public init(cornerSize: CGSize, style: RoundedCornerStyle = .circular) {
        self.cornerSize = cornerSize
        self.style = style
    }

    public init(cornerRadius: CGFloat, style: RoundedCornerStyle = .circular) {
        self.cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        self.style = style
    }

    public func path(in rect: CGRect) -> CGPath {
        guard rect.width >= cornerSize.width * 2 else { return CGPath(rect: .zero, transform: nil) }
        guard rect.height >= cornerSize.height * 2 else { return CGPath(rect: .zero, transform: nil) }
        return CGPath(roundedRect: rect, cornerWidth: cornerSize.width, cornerHeight: cornerSize.height, transform: nil)
    }
}

public struct Capsule: Shape, Equatable {

    public var style: RoundedCornerStyle

    public init(style: RoundedCornerStyle = .circular) {
        self.style = style
    }

    public func path(in rect: CGRect) -> CGPath {
        let radius = min(rect.width, rect.height) / 2
        guard rect.width >= radius * 2 else { return CGPath(rect: .zero, transform: nil) }
        guard rect.height >= radius * 2 else { return CGPath(rect: .zero, transform: nil) }
        return CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil)
    }
}
