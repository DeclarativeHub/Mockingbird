//
//  The MIT License (MIT)
//
//  Created by Srdan Rasic (@srdanrasic) on 22/06/2019.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

public struct Font {

    private enum Name: Hashable {
        case system(Design)
        case custom(String)
    }

    private var name: Name
    private var size: CGFloat
    private var traits: [UIFontDescriptor.TraitKey: Any]
    private var symbolicTraits: UIFontDescriptor.SymbolicTraits
    private var attributes: [UIFontDescriptor.AttributeName: Any]

    public var uiFont: UIFont {
        // TODO: This has to be efficient. Cache?
        var descriptor = UIFontDescriptor(fontAttributes: attributes)
        descriptor = descriptor.withSymbolicTraits(symbolicTraits) ?? descriptor
        if case .custom(let face) = name {
            descriptor = descriptor.withFace(face)
        }
        return UIFont(descriptor: descriptor, size: size)
    }
}

extension Font {

    public func italic() -> Font {
        var copy = self
        copy.symbolicTraits.insert(.traitItalic)
        return copy
    }

    public func smallCaps() -> Font {
        // TODO
        return self
    }

    public func monospacedDigit() -> Font {
        // TODO
        return self

    }

    public func weight(_ weight: UIFont.Weight) -> Font {
        var copy = self
        copy.traits[.weight] = weight
        return copy
    }

    public func bold() -> Font {
        var copy = self
        copy.symbolicTraits.insert(.traitBold)
        return copy
    }
}

extension Font {

    public static let largeTitle = Font.system(.largeTitle)

    public static let title = Font.system(.title)

    public static var headline = Font.system(.headline)

    public static var subheadline = Font.system(.subheadline)

    public static var body = Font.system(.body)

    public static var callout = Font.system(.callout)

    public static var footnote = Font.system(.footnote)

    public static var caption = Font.system(.caption)

    public static func system(_ style: TextStyle, design: Font.Design = .default) -> Font {
        return Font(name: .system(design), size: style.uiFontSize, traits: [:], symbolicTraits: [], attributes: [.textStyle: style.uiFontStyle])
    }

    public static func system(size: CGFloat, design: Font.Design = .default) -> Font {
        return Font(name: .system(design), size: size, traits: [:], symbolicTraits: [], attributes: [:])
    }

    public static func custom(_ name: String, size: CGFloat) -> Font {
        return Font(name: .custom(name), size: size, traits: [:], symbolicTraits: [], attributes: [:])
    }

    public enum Design: Hashable {
        case `default`
        case serif
        case rounded
        case monospaced
    }

    public enum TextStyle: Hashable {
        case largeTitle
        case title
        case headline
        case subheadline
        case body
        case callout
        case footnote
        case caption

        var uiFontStyle: UIFont.TextStyle {
            switch self {
            case .largeTitle:
                if #available(iOS 11.0, *) {
                    return .largeTitle
                } else {
                    return .title1
                }
            case .title:
                return .title1
            case .headline:
                return .headline
            case .subheadline:
                return .subheadline
            case .body:
                return .body
            case .callout:
                return .callout
            case .footnote:
                return .footnote
            case .caption:
                return .caption1
            }
        }

        var uiFontSize: CGFloat {
            switch self {
            case .largeTitle:
                return 36
            case .title:
                return 24
            case .headline:
                return 16
            case .subheadline:
                return 14
            case .body:
                return 16
            case .callout:
                return 15
            case .footnote:
                return 14
            case .caption:
                return 12
            }
        }
    }
}
