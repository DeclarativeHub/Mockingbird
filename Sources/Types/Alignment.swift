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

public enum HorizontalAlignment: Equatable {
    case leading
    case center
    case trailing
}

public enum VerticalAlignment: Equatable {
    case top
    case center
    case bottom
    case firstTextBaseline
    case lastTextBaseline
}

public struct Alignment: Equatable {

    public var horizontal: HorizontalAlignment
    public var vertical: VerticalAlignment

    @inlinable
    public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment) {
        self.horizontal = horizontal
        self.vertical = vertical
    }

    public static let center: Alignment = Alignment(horizontal: .center, vertical: .center)
    public static let leading: Alignment = Alignment(horizontal: .leading, vertical: .center)
    public static let trailing: Alignment = Alignment(horizontal: .trailing, vertical: .center)
    public static let top: Alignment = Alignment(horizontal: .center, vertical: .top)
    public static let bottom: Alignment = Alignment(horizontal: .center, vertical: .bottom)
    public static let topLeading: Alignment = Alignment(horizontal: .leading, vertical: .top)
    public static let topTrailing: Alignment = Alignment(horizontal: .trailing, vertical: .top)
    public static let bottomLeading: Alignment = Alignment(horizontal: .leading, vertical: .bottom)
    public static let bottomTrailing: Alignment = Alignment(horizontal: .trailing, vertical: .bottom)
}

extension HorizontalAlignment {

    @inlinable
    public var flipped: VerticalAlignment {
        switch self {
        case .leading:
            return .top
        case .center:
            return .center
        case .trailing:
            return .bottom
        }
    }
}
