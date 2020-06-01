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

public struct Path: Equatable {

    public var elements: [Element]

    public init(_ elements: [Element]) {
        self.elements = elements
    }

    public init() {
        elements = []
    }

    public init(_ rect: CGRect) {
        self.init {
            $0.addRect(rect)
        }
    }

    public init(roundedRect rect: CGRect, cornerSize: CGSize, style: RoundedCornerStyle = .circular) {
        self.init {
            $0.addRoundedRect(in: rect, cornerSize: cornerSize, style: style)
        }
    }

    public init(roundedRect rect: CGRect, cornerRadius: CGFloat, style: RoundedCornerStyle = .circular) {
        self.init {
            $0.addRoundedRect(in: rect, cornerSize: .init(width: cornerRadius, height: cornerRadius), style: style)
        }
    }

    public init(ellipseIn rect: CGRect) {
        self.init {
            $0.addEllipse(in: rect)
        }
    }

    public init(_ callback: (inout Path) -> ()) {
        var path = Path()
        callback(&path)
        self = path
    }

    public var isEmpty: Bool {
        elements.isEmpty
    }

    public var boundingRect: CGRect {
        fatalError("Not implemented")
    }

    public func contains(_ p: CGPoint, eoFill: Bool = false) -> Bool {
        fatalError("Not implemented")
    }

    public enum Element: Equatable {

        case move(to: CGPoint)

        case line(to: CGPoint)

        case quadCurve(to: CGPoint, control: CGPoint)

        case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)

        case closeSubpath

        var points: [CGPoint] {
            switch self {
            case .move(to: let to):
                return [to]
            case .line(to: let to):
                return [to]
            case .quadCurve(let to, let control):
                return [to, control]
            case .curve(let to, let control1, let control2):
                return [to, control1, control2]
            case .closeSubpath:
                return []
            }
        }

        func mapPoints(_ transform: (CGPoint) -> CGPoint) -> Element {
            switch self {
            case .move(to: let to):
                return .move(to: transform(to))
            case .line(to: let to):
                return .line(to: transform(to))
            case .quadCurve(let to, let control):
                return .quadCurve(to: transform(to), control: transform(control))
            case .curve(let to, let control1, let control2):
                return .curve(to: transform(to), control1: transform(control1), control2: transform(control2))
            case .closeSubpath:
                return .closeSubpath
            }
        }
    }

    public func forEach(_ body: (Element) -> Void) {
        elements.forEach(body)
    }

//    public func strokedPath(_ style: StrokeStyle) -> Path

//    public func trimmedPath(from: CGFloat, to: CGFloat) -> Path
}

extension Path: Shape {

    public func path(in rect: CGRect) -> Path {
        self
    }
}

extension Path {

    public mutating func move(to p: CGPoint) {
        elements.append(.move(to: p))
    }

    public mutating func addLine(to p: CGPoint) {
        elements.append(.line(to: p))
    }

    public mutating func addQuadCurve(to p: CGPoint, control cp: CGPoint) {
        elements.append(.quadCurve(to: p, control: cp))
    }

    public mutating func addCurve(to p: CGPoint, control1 cp1: CGPoint, control2 cp2: CGPoint) {
        elements.append(.curve(to: p, control1: cp1, control2: cp2))
    }

    public mutating func closeSubpath() {
        elements.append(.closeSubpath)
    }

    public mutating func addRect(_ rect: CGRect, transform: CGAffineTransform = .identity) {
        let newElements: [Element] = [
            .move(to: CGPoint(x: rect.minX, y: rect.minY)),
            .line(to: CGPoint(x: rect.maxX, y: rect.minY)),
            .line(to: CGPoint(x: rect.maxX, y: rect.maxY)),
            .line(to: CGPoint(x: rect.minX, y: rect.maxY)),
            .closeSubpath
        ]
        elements.append(contentsOf: newElements)
    }

    public mutating func addRoundedRect(in rect: CGRect, cornerSize: CGSize, style: RoundedCornerStyle = .circular, transform: CGAffineTransform = .identity) {
        let x = rect.minX
        let y = rect.minY
        let w = rect.width
        let h = rect.height
        let cw = cornerSize.width
        let ch = cornerSize.height
        let c: CGFloat = 0.552284749831
        let xe = x + w
        let ye = y + h
        let newElements: [Element] = [
            .move(to: CGPoint(x: xe, y: y + h / 2)),
            .line(to: CGPoint(x: xe, y: ye - ch)),
            .curve(
                to: .init(x: xe, y: ye - ch + ch * c),
                control1: .init(x: xe - cw + cw * c, y: ye),
                control2: .init(x: xe - cw, y: ye)
            ),
            .line(to: CGPoint(x: x + cw, y: ye)),
            .curve(
                to: .init(x: x + (1 - c) * cw, y: ye),
                control1: .init(x: x, y: ye - ch + ch * c),
                control2: .init(x: x, y: ye - ch)
            ),
            .line(to: CGPoint(x: x, y: y + ch)),
            .curve(
                to: .init(x: x, y: y + (1 - c) * ch),
                control1: .init(x: x + (1 - c) * cw, y: y),
                control2: .init(x: x + cw, y: y)
            ),
            .line(to: CGPoint(x: xe - cw, y: y)),
            .curve(
                to: .init(x: xe - cw + cw * c, y: y),
                control1: .init(x: xe, y: y + (1 - c) * ch),
                control2: .init(x: xe, y: y + ch)
            ),
            .closeSubpath
        ]
        elements.append(contentsOf: newElements)
    }

    public mutating func addEllipse(in rect: CGRect, transform: CGAffineTransform = .identity) {
        let x = rect.minX
        let y = rect.minY
        let w = rect.width
        let h = rect.height
        let cw = rect.width / 2
        let ch = rect.height / 2
        let c: CGFloat = 0.552284749831
        let xe = x + w
        let ye = y + h
        let newElements: [Element] = [
            .move(to: CGPoint(x: xe, y: y + h / 2)),
            .curve(
                to: .init(x: xe, y: ye - ch + ch * c),
                control1: .init(x: xe - cw + cw * c, y: ye),
                control2: .init(x: xe - cw, y: ye)
            ),
            .curve(
                to: .init(x: x + (1 - c) * cw, y: ye),
                control1: .init(x: x, y: ye - ch + ch * c),
                control2: .init(x: x, y: ye - ch)
            ),
            .curve(
                to: .init(x: x, y: y + (1 - c) * ch),
                control1: .init(x: x + (1 - c) * cw, y: y),
                control2: .init(x: x + cw, y: y)
            ),
            .curve(
                to: .init(x: xe - cw + cw * c, y: y),
                control1: .init(x: xe, y: y + (1 - c) * ch),
                control2: .init(x: xe, y: y + ch)
            ),
            .closeSubpath
        ]
        elements.append(contentsOf: newElements)
    }

    public mutating func addRects(_ rects: [CGRect], transform: CGAffineTransform = .identity) {
        for rect in rects {
            addRect(rect, transform: transform)
        }
    }

    public mutating func addLines(_ lines: [CGPoint]) {
        guard lines.count > 1 else { return }
        elements.append(.move(to: lines[0]))
        elements.append(contentsOf: lines[1...].map { Element.line(to: $0) })
    }

//    public mutating func addRelativeArc(center: CGPoint, radius: CGFloat, startAngle: Angle, delta: Angle, transform: CGAffineTransform = .identity)

//    public mutating func addArc(center: CGPoint, radius: CGFloat, startAngle: Angle, endAngle: Angle, clockwise: Bool, transform: CGAffineTransform = .identity)

//    public mutating func addArc(tangent1End p1: CGPoint, tangent2End p2: CGPoint, radius: CGFloat, transform: CGAffineTransform = .identity)

    public mutating func addPath(_ path: Path, transform: CGAffineTransform = .identity) {
        elements.append(contentsOf: path.elements)
    }

    public var currentPoint: CGPoint? {
        elements.last?.points.last
    }

    public func applying(_ transform: CGAffineTransform) -> Path {
        Path(
            elements.map {
                $0.mapPoints {
                    $0.applying(transform)
                }
            }
        )
    }

    public func offsetBy(dx: CGFloat, dy: CGFloat) -> Path {
        applying(.init(translationX: dx, y: dy))
    }
}


#if canImport(CoreGraphics)

import CoreGraphics

extension Path {

    public init(_ path: CGPath) {
        elements = path.elements.map { $0.pathElement }
    }

    public init(_ path: CGMutablePath) {
        self.init(path as CGPath)
    }

    public var cgPath: CGPath {
        let path = CGMutablePath()
        for element in elements {
            switch element {
            case .move(let p):
                path.move(to: p)
            case .line(let p):
                path.addLine(to: p)
            case .quadCurve(let p, let cp):
                path.addQuadCurve(to: p, control: cp)
            case .curve(let p, let cp1, let cp2):
                path.addCurve(to: p, control1: cp1, control2: cp2)
            case .closeSubpath:
                path.closeSubpath()
            }
        }
        return path
    }
}

private extension CGPathElement {

    var pathElement: Path.Element {
        switch type {
        case .moveToPoint:
            return .move(to: points[0])
        case .addLineToPoint:
            return .line(to: points[0])
        case .addQuadCurveToPoint:
            return .quadCurve(to: points[0], control: points[1])
        case .addCurveToPoint:
            return .curve(to: points[0], control1: points[1], control2: points[2])
        case .closeSubpath:
            return .closeSubpath
        @unknown default:
            fatalError()
        }
    }
}

private extension CGPath {

    var elements: [CGPathElement] {
        var elements: [CGPathElement] = []
        forEach {
            elements.append($0)
        }
        return elements
    }

    private func forEach( body: @escaping @convention(block) (CGPathElement) -> Void) {
         typealias Body = @convention(block) (CGPathElement) -> Void
         let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
             let body = unsafeBitCast(info, to: Body.self)
             body(element.pointee)
         }
         let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
         apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
     }
}

#endif
