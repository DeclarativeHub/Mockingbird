//
//  Alignment.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

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

    @inlinable public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment) {
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
