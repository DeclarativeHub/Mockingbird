//
//  Text.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

import CoreGraphics

public struct Text: View, Equatable {

    public let storage: Storage

    public init(_ text: String) {
        self.storage = .plain(text)
    }

    public init(_ storage: Storage) {
        self.storage = storage
    }

    public var body: View {
        fatalError()
    }

    public static func +(lhs: Text, rhs: Text) -> Text {
        return Text(Storage.concatenated(lhs.storage, rhs.storage))
    }
}

extension Text {

    public enum Attribute: Hashable {
        case foregroundColor(Color?)
        case font(Font?)
        case fontWeight(Font.Weight?)
        case bold
        case italic
        case strikethrough(active: Bool, color: Color?)
        case underline(active: Bool, color: Color?)
        case kerning(CGFloat?)
        case tracking(CGFloat?)
        case baselineOffset(CGFloat?)
    }

    public indirect enum Storage: Hashable {
        case plain(String)
        case attributed(Storage, Attribute)
        case concatenated(Storage, Storage)
    }

    public func foregroundColor(_ color: Color?) -> Text {
        return Text(.attributed(storage, .foregroundColor(color)))
    }

    public func font(_ font: Font?) -> Text {
        return Text(.attributed(storage, .font(font)))
    }

    public func fontWeight(_ weight: Font.Weight?) -> Text {
        return Text(.attributed(storage, .fontWeight(weight)))
    }

    public func bold() -> Text {
        return Text(.attributed(storage, .bold))
    }

    public func italic() -> Text {
        return Text(.attributed(storage, .italic))
    }

    public func strikethrough(_ active: Bool = true, color: Color? = nil) -> Text {
        return Text(.attributed(storage, .strikethrough(active: active, color: color)))
    }

    public func underline(_ active: Bool = true, color: Color? = nil) -> Text {
        return Text(.attributed(storage, .underline(active: active, color: color)))
    }

    public func kerning(_ kerning: CGFloat) -> Text {
        return Text(.attributed(storage, .kerning(kerning)))
    }

    public func tracking(_ tracking: CGFloat) -> Text {
        return Text(.attributed(storage, .tracking(tracking)))
    }

    public func baselineOffset(_ baselineOffset: CGFloat) -> Text {
        return Text(.attributed(storage, .baselineOffset(baselineOffset)))
    }
}

extension Text {

    public enum TruncationMode: Hashable {

        case head
        case tail
        case middle
    }
}

public enum TextAlignment: Hashable {

    case leading
    case center
    case trailing
}
