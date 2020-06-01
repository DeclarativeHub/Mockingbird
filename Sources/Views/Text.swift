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

public struct Text: View, Hashable {

    public typealias Body = Swift.Never

    public let storage: Storage

    @inlinable
    public init(_ text: String) {
        self.storage = .plain(text)
    }

    @inlinable
    public init(_ storage: Storage) {
        self.storage = storage
    }

    @inlinable
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

    @inlinable
    public func foregroundColor(_ color: Color?) -> Text {
        return Text(.attributed(storage, .foregroundColor(color)))
    }

    @inlinable
    public func font(_ font: Font?) -> Text {
        return Text(.attributed(storage, .font(font)))
    }

    @inlinable
    public func fontWeight(_ weight: Font.Weight?) -> Text {
        return Text(.attributed(storage, .fontWeight(weight)))
    }

    @inlinable
    public func bold() -> Text {
        return Text(.attributed(storage, .bold))
    }

    @inlinable
    public func italic() -> Text {
        return Text(.attributed(storage, .italic))
    }

    @inlinable
    public func strikethrough(_ active: Bool = true, color: Color? = nil) -> Text {
        return Text(.attributed(storage, .strikethrough(active: active, color: color)))
    }

    @inlinable
    public func underline(_ active: Bool = true, color: Color? = nil) -> Text {
        return Text(.attributed(storage, .underline(active: active, color: color)))
    }

    @inlinable
    public func kerning(_ kerning: CGFloat) -> Text {
        return Text(.attributed(storage, .kerning(kerning)))
    }

    @inlinable
    public func tracking(_ tracking: CGFloat) -> Text {
        return Text(.attributed(storage, .tracking(tracking)))
    }

    @inlinable
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
