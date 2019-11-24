//
//  Color.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

public struct Color: View {

    public let rgba: (red: Double, green: Double, blue: Double, alpha: Double)

    public init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.rgba = (red, green, blue, alpha)
    }

    public init(white: Double, opacity: Double) {
        self.rgba = (white, white, white, opacity)
    }

    public var body: View {
        fatalError()
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

    public func opacity(_ alpha: Double) -> Color {
        return Color(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: alpha)
    }
}

extension Color: Hashable {

    public static func == (lhs: Color, rhs: Color) -> Bool {
        return lhs.rgba == rhs.rgba
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rgba.red)
        hasher.combine(rgba.green)
        hasher.combine(rgba.blue)
        hasher.combine(rgba.alpha)
    }
}
