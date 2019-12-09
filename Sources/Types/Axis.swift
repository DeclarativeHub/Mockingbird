//
//  Axis.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 17/11/2019.
//

public enum Axis {
    case vertical
    case horizontal
}

extension Axis {

    @inlinable
    public var flipped: Axis {
        switch self {
        case .horizontal:
            return .vertical
        case .vertical:
            return .horizontal
        }
    }
}
