//
//  ViewArray.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

public struct ViewContent: View, ViewList {

    public let content: [View]

    @inlinable
    public init(_ content: [View]) {
        self.content = content
    }

    public var body: View {
        fatalError()
    }

    public func makeViews() -> [View] {
        return content
    }
}

public protocol ViewList {
    func makeViews() -> [View]
}

extension View {

    @inlinable
    public var flattened: [View] {
        if let view = self as? ViewList {
            return view.makeViews()
        } else {
            return [self]
        }
    }
}
