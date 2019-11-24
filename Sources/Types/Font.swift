//
//  Font.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 13/11/2019.
//

import CoreGraphics

public struct Font: Hashable {

    public enum Descriptor: Hashable {

        public struct Attributes: Hashable {
            var isItalic: Bool = false
            var isSsmallCaps: Bool = false
            var isLowercaseSmallCaps: Bool = false
            var isUppercaseSmallCaps: Bool = false
            var isMonospacedDigit: Bool = false
            var isBold: Bool = false
        }

        case system(size: CGFloat, weight: Weight, design: Design, attributes: Attributes)
        case custom(name: String, size: CGFloat)
    }

    public var descriptor: Descriptor

    public func italic() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isItalic = true })
    }

    public func smallCaps() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isSsmallCaps = true })
    }

    public func lowercaseSmallCaps() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isLowercaseSmallCaps = true })
    }

    public func uppercaseSmallCaps() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isUppercaseSmallCaps = true })
    }

    public func monospacedDigit() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isMonospacedDigit = true })
    }

    public func weight(_ weight: Font.Weight) -> Font {
        return Font(descriptor: descriptor.modifyingWeight(weight))
    }

    public func bold() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isBold = true })
    }

    public enum Weight: Hashable {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
    }
}

extension Font {

    public static let largeTitle: Font = .system(.largeTitle)

    public static let title: Font = .system(.title)

    public static var headline: Font = .system(.headline)

    public static var subheadline: Font = .system(.subheadline)

    public static var body: Font = .system(.body)

    public static var callout: Font = .system(.callout)

    public static var footnote: Font = .system(.footnote)

    public static var caption: Font = .system(.caption)

    public static func system(_ style: Font.TextStyle, design: Font.Design = .default) -> Font {
        switch style {
        case .largeTitle:
            return .system(size: 32, weight: .bold, design: design)
        case .title:
            return .system(size: 26, weight: .bold, design: design)
        case .headline:
            return .system(size: 16, weight: .regular, design: design)
        case .subheadline:
            return .system(size: 14, weight: .regular, design: design)
        case .body:
            return .system(size: 14, weight: .regular, design: design)
        case .callout:
            return .system(size: 12, weight: .regular, design: design)
        case .footnote:
            return .system(size: 12, weight: .regular, design: design)
        case .caption:
            return .system(size: 12, weight: .regular, design: design)
        }
    }

    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        return Font(descriptor: .system(size: size, weight: weight, design: design, attributes: .init()))
    }

    public static func custom(_ name: String, size: CGFloat) -> Font {
        return Font(descriptor: .custom(name: name, size: size))
    }

    public enum TextStyle: CaseIterable {

        case largeTitle
        case title
        case headline
        case subheadline
        case body
        case callout
        case footnote
        case caption
    }

    public enum Design : Hashable {
        case `default`
        case serif
        case rounded
        case monospaced
    }
}

private extension Font.Descriptor {

    func modifyingAttributes(_ modify: (inout Attributes) -> Void) -> Font.Descriptor {
        switch self {
        case .system(let size, let weight, let design, var attributes):
            modify(&attributes)
            return .system(size: size, weight: weight, design: design, attributes: attributes)
        case .custom(let name, let size):
            return .custom(name: name, size: size)
        }
    }

    func modifyingWeight(_ newWeight: Font.Weight) -> Font.Descriptor {
        switch self {
        case .system(let size, _, let design, let attributes):
            return .system(size: size, weight: newWeight, design: design, attributes: attributes)
        case .custom(let name, let size):
            return .custom(name: name, size: size)
        }
    }
}
