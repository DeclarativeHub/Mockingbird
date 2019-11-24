//
//  CoordinateSpace.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

public enum CoordinateSpace {

    case global
    case local
    case named(AnyHashable)
}

extension CoordinateSpace {

    public var isGlobal: Bool {
        switch self {
        case .global:
            return true
        default:
            return false
        }
    }

    public var isLocal: Bool {
        switch self {
        case .local:
            return true
        default:
            return false
        }
    }
}
