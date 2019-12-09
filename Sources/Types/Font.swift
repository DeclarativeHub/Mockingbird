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
            public var isItalic: Bool = false
            public var isSsmallCaps: Bool = false
            public var isLowercaseSmallCaps: Bool = false
            public var isUppercaseSmallCaps: Bool = false
            public var isMonospacedDigit: Bool = false
            public var isBold: Bool = false

            @inlinable
            public init() {}
        }

        case system(size: CGFloat, weight: Weight, design: Design, attributes: Attributes)
        case custom(name: String, size: CGFloat)
    }

    public var descriptor: Descriptor

    @inlinable
    public init(descriptor: Descriptor) {
        self.descriptor = descriptor
    }

    @inlinable
    public func italic() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isItalic = true })
    }

    @inlinable
    public func smallCaps() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isSsmallCaps = true })
    }

    @inlinable
    public func lowercaseSmallCaps() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isLowercaseSmallCaps = true })
    }

    @inlinable
    public func uppercaseSmallCaps() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isUppercaseSmallCaps = true })
    }

    @inlinable
    public func monospacedDigit() -> Font {
        return Font(descriptor: descriptor.modifyingAttributes { $0.isMonospacedDigit = true })
    }

    @inlinable
    public func weight(_ weight: Font.Weight) -> Font {
        return Font(descriptor: descriptor.modifyingWeight(weight))
    }

    @inlinable
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

    @inlinable
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

    @inlinable
    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        return Font(descriptor: .system(size: size, weight: weight, design: design, attributes: .init()))
    }

    @inlinable
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

extension Font.Descriptor {

    @inlinable
    public func modifyingAttributes(_ modify: (inout Attributes) -> Void) -> Font.Descriptor {
        switch self {
        case .system(let size, let weight, let design, var attributes):
            modify(&attributes)
            return .system(size: size, weight: weight, design: design, attributes: attributes)
        case .custom(let name, let size):
            return .custom(name: name, size: size)
        }
    }

    @inlinable
    public func modifyingWeight(_ newWeight: Font.Weight) -> Font.Descriptor {
        switch self {
        case .system(let size, _, let design, let attributes):
            return .system(size: size, weight: newWeight, design: design, attributes: attributes)
        case .custom(let name, let size):
            return .custom(name: name, size: size)
        }
    }
}
